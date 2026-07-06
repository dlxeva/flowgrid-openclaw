# Recording Plan After Local Pass

## Current Gate

Local demo has passed on Windows 11 with Git for Windows Bash.

The video can now be recorded from the verified path.

## Verified Command

```powershell
cd C:\Users\夕颜\.openclaw\workspace\flowgrid-openclaw
& "C:\Program Files\Git\bin\bash.exe" scripts/run_local_demo.sh
```

## Recording Goal

The video must prove four things:

1. OpenClaw / OpenCore is the local host and operator.
2. FlowGrid is called by the workflow as the project-state layer.
3. The workflow creates real local project files.
4. A later session can resume from `flg handoff`.

## Required Screen Layout

Recommended layout:

- Left: OpenClaw / OpenCore window
- Right top: PowerShell / Git Bash terminal
- Right bottom: VS Code or file explorer opened at `flowgrid-openclaw`

If screen space is limited, record in this order:

1. OpenClaw / OpenCore receives task
2. Terminal runs the demo
3. VS Code shows generated files
4. Terminal shows `flg handoff`

## Shot List

### Shot 1: Project Intro

Show:

- README or PPT cover
- project name: FlowGrid for OpenClaw
- core carrier: OpenClaw
- protocol layer: FlowGrid

Say:

> FlowGrid for OpenClaw is a resumable project-state agent for knowledge work. It addresses the loss of decisions, risks, and next actions across AI sessions.

### Shot 2: OpenClaw / OpenCore Receives Task

Paste this prompt into local OpenClaw / OpenCore:

```text
You are the local execution host for FlowGrid for OpenClaw. Run the verified local demo path and show that OpenClaw is operating FlowGrid as a project-state workflow. The target loop is: start project, save raw session, closeout, review, merge, resume.
```

Show:

- OpenClaw / OpenCore receives the task
- it prepares to operate the local demo

### Shot 3: Run Verified Demo Command

Show terminal running:

```powershell
cd C:\Users\夕颜\.openclaw\workspace\flowgrid-openclaw
& "C:\Program Files\Git\bin\bash.exe" scripts/run_local_demo.sh
```

Must capture these log markers:

- `[1/7] Initialize FlowGrid project`
- `[2/7] Save raw session`
- `[3/7] Close out session`
- `Latest patch:`
- `[5/7] Review decisions`
- `Accepted 1 decision(s) into DECISIONS.md`
- `[6/7] Merge patch`
- `Merge complete`
- `[7/7] Resume project`

### Shot 4: Show Generated Evidence

Open:

```text
.demo-runtime/ai-collaboration-sharing/
```

Show:

- `PROJECT.md`
- `FRAMING.md`
- `SNAPSHOT.md`
- `DECISIONS.md`
- `PROGRESS.md`
- `.flg/sessions/session-001.md`
- `.flg/patches/closeout-20260706-234808-8c4a92.patch.md`
- `.flg/merge_logs/2026-07-06T23-48-11-merge.md`

Emphasize:

- raw session exists
- closeout patch exists
- decision entered formal ledger after review
- progress entered ledger after merge

### Shot 5: Resume / Handoff

Run inside the generated project directory:

```powershell
cd C:\Users\夕颜\.openclaw\workspace\flowgrid-openclaw\.demo-runtime\ai-collaboration-sharing
flg status
flg handoff
```

Show:

- project state summary
- handoff output
- confirmed decisions and suggested next actions

Note:

The current FlowGrid CLI may still mention a stale pending patch after merge. Do not highlight this in the video. It is a non-blocking state-summary bug already recorded for follow-up.

### Shot 6: Architecture Explanation

Show either the PPT architecture page or:

```text
docs/openclaw-framework-alignment.md
```

Say:

> OpenClaw is the host and workflow operator. FlowGrid is the local project-state protocol. Sessions are saved as raw evidence, closeout creates reviewable patches, reviewed decisions enter DECISIONS.md, and handoff lets the next session resume without restating context.

### Shot 7: Closing

Say:

> This demo shows FlowGrid for OpenClaw turning a single AI session into durable project state. It is designed for creators, researchers, strategists, and operators who need AI collaboration to continue across sessions.

## Time Budget

- Intro: 15 seconds
- OpenClaw / OpenCore task: 30 seconds
- demo command: 90 seconds
- generated evidence: 60 seconds
- handoff / resume: 45 seconds
- architecture explanation: 40 seconds
- closing: 20 seconds

Target: 4 to 5 minutes.

## Recording Rules

Do:

- show real local terminal output
- show generated files
- show OpenClaw / OpenCore as the operator
- keep the video under 5 minutes
- record at 1080P or higher

Do not:

- record long setup or installation
- read the entire PPT aloud
- over-explain the stale pending patch issue
- claim a complete OpenClaw plugin is already packaged
- claim multi-agent orchestration is implemented in v0
