#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEMO_ROOT="${ROOT_DIR}/.demo-runtime"
PROJECT_DIR="${DEMO_ROOT}/ai-collaboration-sharing"
SESSION_SOURCE="${ROOT_DIR}/examples/creator-project-demo/session-001.md"

printf "\n[FlowGrid for OpenClaw] Local demo\n"
printf "Root: %s\n" "$ROOT_DIR"

if ! command -v flg >/dev/null 2>&1; then
  printf "\nERROR: flg command not found.\n"
  printf "Install FlowGrid first, for example from the FlowGrid core repository:\n"
  printf "  pip install -e /path/to/FlowGrid\n"
  exit 1
fi

rm -rf "$DEMO_ROOT"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

printf "\n[1/7] Initialize FlowGrid project\n"
flg init "AI Collaboration Sharing" --type proposal --client "Demo User"

printf "\n[2/7] Save raw session\n"
mkdir -p .flg/sessions
cp "$SESSION_SOURCE" .flg/sessions/session-001.md
ls -la .flg/sessions

printf "\n[3/7] Close out session\n"
flg closeout --transcript .flg/sessions/session-001.md

PATCH_FILE="$(ls -t .flg/patches/*.md | head -n 1)"
printf "Latest patch: %s\n" "$PATCH_FILE"

printf "\n[4/7] Show patch preview\n"
sed -n '1,180p' "$PATCH_FILE"

printf "\n[5/7] Review decisions\n"
flg review --patch "$PATCH_FILE" --accept-all

printf "\n[6/7] Merge patch\n"
flg merge --patch "$PATCH_FILE" --yes

printf "\n[7/7] Resume project\n"
flg status
flg handoff

printf "\nGenerated project directory:\n%s\n" "$PROJECT_DIR"
printf "\nKey files:\n"
printf "- %s/PROJECT.md\n" "$PROJECT_DIR"
printf "- %s/DECISIONS.md\n" "$PROJECT_DIR"
printf "- %s/PROGRESS.md\n" "$PROJECT_DIR"
printf "- %s/SNAPSHOT.md\n" "$PROJECT_DIR"
printf "- %s/.flg/patches\n" "$PROJECT_DIR"
