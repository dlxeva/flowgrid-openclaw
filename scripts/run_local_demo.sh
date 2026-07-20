#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEMO_ROOT="${ROOT_DIR}/.demo-runtime"
PROJECT_DIR="${DEMO_ROOT}/ai-collaboration-sharing"
SESSION_SOURCE="${ROOT_DIR}/examples/creator-project-demo/session-001.md"
ADAPTER="${ROOT_DIR}/openclaw_app/tools/flowgrid_adapter.py"
CORE_LOCK="${ROOT_DIR}/flowgrid-core.lock"
PYTHON_BIN="${PYTHON_BIN:-python3}"
export FLOWGRID_BIN="${FLOWGRID_BIN:-flg}"

printf "\n[FlowGrid for OpenClaw] Executable local demo\n"
printf "Root: %s\n" "$ROOT_DIR"
printf "FlowGrid binary: %s\n" "$FLOWGRID_BIN"

if ! command -v "$FLOWGRID_BIN" >/dev/null 2>&1; then
  printf "\nERROR: FLOWGRID_BIN is not executable: %s\n" "$FLOWGRID_BIN"
  printf "Set FLOWGRID_BIN to a FlowGrid CLI, for example:\n"
  printf "  FLOWGRID_BIN=/path/to/FlowGrid/.venv/bin/flg bash scripts/run_local_demo.sh\n"
  exit 1
fi

LOCK_VERSION="$(awk -F ': ' '/^core_version:/{print $2}' "$CORE_LOCK")"
LOCK_COMMIT="$(awk -F ': ' '/^core_commit:/{print $2}' "$CORE_LOCK")"
if [[ -z "$LOCK_VERSION" || -z "$LOCK_COMMIT" ]]; then
  printf "ERROR: invalid core lock file: %s\n" "$CORE_LOCK"
  exit 1
fi
if ! "$FLOWGRID_BIN" version | grep -Fq "v${LOCK_VERSION}"; then
  printf "ERROR: FlowGrid version does not match lock (%s).\n" "$LOCK_VERSION"
  exit 1
fi
if [[ -n "${FLOWGRID_REPO:-}" ]]; then
  ACTUAL_COMMIT="$(git -C "$FLOWGRID_REPO" rev-parse HEAD)"
  if [[ "$ACTUAL_COMMIT" != "$LOCK_COMMIT" ]]; then
    printf "ERROR: FlowGrid commit does not match lock.\nExpected: %s\nActual:   %s\n" "$LOCK_COMMIT" "$ACTUAL_COMMIT"
    exit 1
  fi
fi
printf "Core lock: v%s (%s)\n" "$LOCK_VERSION" "$LOCK_COMMIT"

adapter_call() {
  local request="$1"
  local response
  response="$(printf '%s\n' "$request" | "$PYTHON_BIN" "$ADAPTER" --serve)"
  printf '%s\n' "$response"
  RESPONSE="$response" "$PYTHON_BIN" - <<'PY'
import json, os, sys
response = json.loads(os.environ["RESPONSE"])
if not response.get("ok"):
    raise SystemExit(response.get("error", "adapter failed"))
PY
}

request_json() {
  "$PYTHON_BIN" - "$@" <<'PY'
import json, sys
tool, project_dir = sys.argv[1:3]
payload = json.loads(sys.argv[3]) if len(sys.argv) > 3 else {}
print(json.dumps({"request_id": f"demo-{tool}", "tool": tool, "project_dir": project_dir, **payload}, ensure_ascii=False))
PY
}

response_field() {
  RESPONSE="$1" "$PYTHON_BIN" - "$2" <<'PY'
import json, os, sys
value = json.loads(os.environ["RESPONSE"])["result"]
for key in sys.argv[1].split("."):
    value = value[key]
print(value)
PY
}

rm -rf "$DEMO_ROOT"
mkdir -p "$DEMO_ROOT"

printf "\n[1/6] OpenClaw tool: initialize_project\n"
INIT_RESPONSE="$(adapter_call "$(request_json initialize_project "$PROJECT_DIR" '{"project_name":"AI Collaboration Sharing","project_type":"proposal","client":"Demo User"}')")"
printf '%s\n' "$INIT_RESPONSE"

printf "\n[2/6] OpenClaw tool: save_session\n"
SAVE_REQUEST="$($PYTHON_BIN - "$PROJECT_DIR" "$SESSION_SOURCE" <<'PY'
import json, sys
print(json.dumps({
    "request_id": "demo-save-session",
    "tool": "save_session",
    "project_dir": sys.argv[1],
    "session_id": "session-001",
    "content": open(sys.argv[2], encoding="utf-8").read(),
}, ensure_ascii=False))
PY
)"
SAVE_RESPONSE="$(adapter_call "$SAVE_REQUEST")"
printf '%s\n' "$SAVE_RESPONSE"

printf "\n[3/6] OpenClaw tool: closeout_session\n"
CLOSEOUT_RESPONSE="$(adapter_call "$(request_json closeout_session "$PROJECT_DIR" '{"session_id":"session-001"}')")"
printf '%s\n' "$CLOSEOUT_RESPONSE"
PATCH_FILE="$(response_field "$CLOSEOUT_RESPONSE" patch)"
printf "Patch: %s\n" "$PATCH_FILE"

printf "\n[4/6] OpenClaw tool: review_decisions\n"
REVIEW_PAYLOAD="$($PYTHON_BIN - "$PATCH_FILE" <<'PY'
import json, sys
print(json.dumps({"patch": sys.argv[1], "mode": "accept_all"}))
PY
)"
REVIEW_RESPONSE="$(adapter_call "$(request_json review_decisions "$PROJECT_DIR" "$REVIEW_PAYLOAD")")"
printf '%s\n' "$REVIEW_RESPONSE"

printf "\n[5/6] OpenClaw tool: merge_patch\n"
MERGE_PAYLOAD="$($PYTHON_BIN - "$PATCH_FILE" <<'PY'
import json, sys
print(json.dumps({"patch": sys.argv[1]}))
PY
)"
MERGE_RESPONSE="$(adapter_call "$(request_json merge_patch "$PROJECT_DIR" "$MERGE_PAYLOAD")")"
printf '%s\n' "$MERGE_RESPONSE"

printf "\n[6/6] OpenClaw tool: resume_project\n"
RESUME_RESPONSE="$(adapter_call "$(request_json resume_project "$PROJECT_DIR")")"
printf '%s\n' "$RESUME_RESPONSE"

printf "\n[assertions] Verify durable state and executable tool trace\n"
PROJECT_DIR="$PROJECT_DIR" PATCH_FILE="$PATCH_FILE" "$PYTHON_BIN" - <<'PY'
import json, os
from pathlib import Path

root = Path(os.environ["PROJECT_DIR"])
patch_filename = os.environ["PATCH_FILE"]
patch_path = root / ".flg" / "patches" / patch_filename
patch_id = next(
    line.split(":", 1)[1].strip()
    for line in patch_path.read_text(encoding="utf-8").splitlines()
    if line.startswith("patch_id:")
)
required = [
    root / ".flg" / "sessions" / "session-001.md",
    root / ".flg" / "context" / "evidence_index.json",
    root / ".flg" / "openclaw-tool-trace.jsonl",
    root / "DECISIONS.md",
    root / "SNAPSHOT.md",
]
missing = [str(path) for path in required if not path.exists()]
if missing:
    raise SystemExit("missing demo artifacts: " + ", ".join(missing))

evidence = json.loads((root / ".flg" / "context" / "evidence_index.json").read_text(encoding="utf-8"))
if not any(item.get("status") == "confirmed" for item in evidence.get("items", {}).values()):
    raise SystemExit("demo produced no confirmed decision evidence")

trace = [json.loads(line) for line in (root / ".flg" / "openclaw-tool-trace.jsonl").read_text(encoding="utf-8").splitlines()]
tools = [event["tool"] for event in trace]
expected = ["initialize_project", "save_session", "closeout_session", "review_decisions", "merge_patch", "resume_project"]
if tools != expected:
    raise SystemExit(f"unexpected tool trace: {tools}")
if not any(entry.get("patch_id") == patch_id and entry.get("status") == "merged" for entry in json.loads((root / ".flg" / "state.json").read_text())["pending_patches"]):
    raise SystemExit("patch lifecycle was not merged")
print("PASS: session -> tool calls -> review evidence -> merged ledger -> handoff")
PY

printf "\nGenerated project directory: %s\n" "$PROJECT_DIR"
printf "Trace: %s/.flg/openclaw-tool-trace.jsonl\n" "$PROJECT_DIR"
