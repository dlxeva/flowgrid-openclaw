# Project State Loop Workflow

## Purpose

This workflow is the minimum OpenClaw-visible loop for the competition demo.

It shows how OpenClaw can operate FlowGrid as a local project-state layer.

## Workflow Overview

```text
User natural-language work
  → OpenClaw Project State Agent
  → FlowGrid Adapter
  → local ledger files
  → human review
  → resumed project state
```

## Step 1: Start Project

User says:

```text
Start a FlowGrid project for this sharing plan.
```

OpenClaw action:

```bash
flg init "AI Collaboration Sharing" --type proposal --client "Demo User"
```

Visible proof:

- core markdown ledger files are created
- `.flg/` directory exists

## Step 2: Work Naturally

User discusses:

- project goal
- target audience
- pain points
- candidate structure
- next actions

OpenClaw action:

- respond naturally
- keep enough session material to preserve raw context
- identify decision points

## Step 3: Save Raw Session

OpenClaw action:

```bash
mkdir -p .flg/sessions
cp ../../examples/creator-project-demo/session-001.md .flg/sessions/session-001.md
```

Visible proof:

- `.flg/sessions/session-001.md` exists

## Step 4: Close Out Session

OpenClaw action:

```bash
flg closeout --transcript .flg/sessions/session-001.md
```

Visible proof:

- `.flg/patches/` contains a new patch
- patch includes decisions, risks, and next actions

## Step 5: Review Candidate Decisions

OpenClaw action:

```bash
flg review --patch .flg/patches/<patch-file>.md --accept-all
```

Visible proof:

- `DECISIONS.md` has accepted decisions
- patch review status is updated

## Step 6: Merge Patch

OpenClaw action:

```bash
flg merge --patch .flg/patches/<patch-file>.md
```

Visible proof:

- `PROGRESS.md` is updated
- merge log exists
- patch status is merged

Note:

`flg merge` asks for human confirmation. For scripted local verification, use:

```bash
printf "y\n" | flg merge --patch .flg/patches/<patch-file>.md
```

## Step 7: Resume Project

OpenClaw action:

```bash
flg status
flg handoff
```

Visible proof:

- OpenClaw can summarize the project without asking the user to re-explain
- current decisions and next actions are available from local files

## Demo Success Criteria

The workflow is successful if the video shows:

- OpenClaw as the visible host
- FlowGrid commands triggered by OpenClaw
- raw session saved before closeout
- candidate decisions reviewed before merge
- later resume from local project ledger

## Implementation Note

The first implementation can be script-driven. The demo should still show OpenClaw as the operator that chooses or narrates each step.

After the demo path is stable, this workflow can be turned into a cleaner OpenClaw skill or tool package.
