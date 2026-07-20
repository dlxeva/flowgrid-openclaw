#!/usr/bin/env python3
"""JSONL stdio adapter that lets an OpenClaw tool runner invoke FlowGrid.

The adapter is intentionally host-neutral: OpenClaw only needs to pass each
tool request as one JSON object on stdin and consume one JSON result on stdout.
Every invocation writes a bounded, local trace under .flg/ for demo and audit.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[2]
MANIFEST = ROOT / "openclaw_app" / "manifest.json"
SESSION_ID_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9_-]{0,80}$")


def now() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds")


def flg_binary() -> str:
    return os.environ.get("FLOWGRID_BIN", "flg")


def project_path(value: object) -> Path:
    if not isinstance(value, str) or not value.strip():
        raise ValueError("project_dir must be a non-empty string")
    return Path(value).expanduser().resolve()


def safe_session_id(value: object) -> str:
    if not isinstance(value, str) or not SESSION_ID_RE.fullmatch(value):
        raise ValueError("session_id must contain only letters, digits, _ or -")
    return value


def run_flg(project_dir: Path, args: list[str]) -> dict[str, Any]:
    completed = subprocess.run(
        [flg_binary(), *args],
        cwd=project_dir,
        capture_output=True,
        text=True,
        check=False,
    )
    return {
        "argv": [flg_binary(), *args],
        "exit_code": completed.returncode,
        "stdout": completed.stdout[-12000:],
        "stderr": completed.stderr[-4000:],
    }


def require_success(result: dict[str, Any]) -> None:
    if result["exit_code"] != 0:
        raise RuntimeError(result["stderr"] or result["stdout"] or "FlowGrid command failed")


def latest_patch(project_dir: Path) -> str:
    patches = sorted(
        (project_dir / ".flg" / "patches").glob("*.patch.md"),
        key=lambda path: path.stat().st_mtime,
        reverse=True,
    )
    if not patches:
        raise RuntimeError("closeout did not create a patch")
    return patches[0].name


def append_trace(project_dir: Path, event: dict[str, Any]) -> None:
    trace_path = project_dir / ".flg" / "openclaw-tool-trace.jsonl"
    trace_path.parent.mkdir(parents=True, exist_ok=True)
    with trace_path.open("a", encoding="utf-8") as handle:
        handle.write(json.dumps(event, ensure_ascii=False) + "\n")


def handle(request: dict[str, Any]) -> dict[str, Any]:
    tool = request.get("tool")
    request_id = request.get("request_id", "unknown")
    project_dir = project_path(request.get("project_dir"))
    result: dict[str, Any]

    if tool == "initialize_project":
        project_dir.mkdir(parents=True, exist_ok=True)
        args = ["init", str(request.get("project_name", "Untitled Project"))]
        if request.get("project_type"):
            args.extend(["--type", str(request["project_type"])])
        if request.get("client"):
            args.extend(["--client", str(request["client"])])
        result = run_flg(project_dir, args)
        require_success(result)
        payload = {"project_dir": str(project_dir), "files_created": ["PROJECT.md", "SNAPSHOT.md", "DECISIONS.md", ".flg/"]}
    elif tool == "save_session":
        session_id = safe_session_id(request.get("session_id"))
        content = request.get("content")
        if not isinstance(content, str) or not content.strip():
            raise ValueError("content must be a non-empty string")
        session_path = project_dir / ".flg" / "sessions" / f"{session_id}.md"
        session_path.parent.mkdir(parents=True, exist_ok=True)
        session_path.write_text(content, encoding="utf-8")
        result = {"argv": [], "exit_code": 0, "stdout": "session saved", "stderr": ""}
        payload = {"session": str(session_path.relative_to(project_dir)), "bytes": len(content.encode("utf-8"))}
    elif tool == "closeout_session":
        session_id = safe_session_id(request.get("session_id"))
        session_path = project_dir / ".flg" / "sessions" / f"{session_id}.md"
        if not session_path.exists():
            raise ValueError(f"session not found: {session_path}")
        result = run_flg(project_dir, ["closeout", "--transcript", str(session_path.relative_to(project_dir)), "--no-llm"])
        require_success(result)
        payload = {"patch": latest_patch(project_dir), "session": str(session_path.relative_to(project_dir))}
    elif tool == "review_decisions":
        patch = str(request.get("patch", ""))
        if request.get("mode") != "accept_all":
            raise ValueError("adapter supports only explicit demo mode=accept_all; interactive review stays in the host UI")
        result = run_flg(project_dir, ["review", "--patch", patch, "--accept-all"])
        require_success(result)
        payload = {"patch": patch, "review_mode": "accept_all", "authority": "medium"}
    elif tool == "merge_patch":
        patch = str(request.get("patch", ""))
        result = run_flg(project_dir, ["merge", "--patch", patch, "--yes"])
        require_success(result)
        payload = {"patch": patch, "merged": True}
    elif tool == "resume_project":
        status = run_flg(project_dir, ["status"])
        handoff = run_flg(project_dir, ["handoff"])
        require_success(status)
        require_success(handoff)
        payload = {
            "status": status["stdout"],
            "handoff": handoff["stdout"],
            "agent_response": "Project state recovered from the local FlowGrid ledger. Continue from the current goal and confirmed decisions in the handoff.",
        }
        result = {"argv": status["argv"] + handoff["argv"], "exit_code": 0, "stdout": "resume complete", "stderr": ""}
    else:
        raise ValueError(f"unsupported tool: {tool}")

    event = {
        "timestamp": now(),
        "request_id": request_id,
        "tool": tool,
        "project_dir": str(project_dir),
        "result": {"exit_code": result["exit_code"], "argv": result["argv"]},
        "artifacts": payload,
    }
    append_trace(project_dir, event)
    return {"ok": True, "request_id": request_id, "tool": tool, "result": payload, "trace": ".flg/openclaw-tool-trace.jsonl"}


def serve() -> int:
    for raw in sys.stdin:
        try:
            request = json.loads(raw)
            if not isinstance(request, dict):
                raise ValueError("request must be a JSON object")
            response = handle(request)
        except Exception as exc:  # A tool runner needs structured failures.
            response = {"ok": False, "error": str(exc)}
        print(json.dumps(response, ensure_ascii=False), flush=True)
    return 0


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--manifest", action="store_true")
    parser.add_argument("--serve", action="store_true")
    args = parser.parse_args()
    if args.manifest:
        print(MANIFEST.read_text(encoding="utf-8"))
        return 0
    if args.serve:
        return serve()
    parser.error("choose --manifest or --serve")
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
