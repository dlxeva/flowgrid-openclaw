# FlowGrid Adapter

## Purpose

This adapter defines how OpenClaw should call FlowGrid during the competition demo.

The adapter can start as a documented shell-command wrapper. It does not need to become a polished plugin before the demo is proven.

## Required Commands

### initialize_project

Intent:

Create a new FlowGrid project ledger.

Command:

```bash
flg init "<project_name>" --type proposal --client "<client_name>"
```

Expected result:

- `PROJECT.md`
- `FRAMING.md`
- `SNAPSHOT.md`
- `DECISIONS.md`
- `PROGRESS.md`
- `.flg/`

### save_session

Intent:

Persist raw user-agent discussion before interpretation.

Command shape:

```bash
mkdir -p .flg/sessions
cat > .flg/sessions/<session_id>.md <<'EOF'
<raw session text>
EOF
```

Expected result:

- raw session material exists under `.flg/sessions/`

### closeout_session

Intent:

Extract candidate decisions, risks, open questions, and next actions from a raw session.

Command:

```bash
flg closeout --transcript .flg/sessions/<session_id>.md
```

Expected result:

- a new patch under `.flg/patches/`
- state updated with pending patch metadata

### review_decisions

Intent:

Let the human confirm candidate decisions before formalizing them.

Command:

```bash
flg review --patch .flg/patches/<patch_file>.md
```

Expected result:

- accepted decisions are appended to `DECISIONS.md`
- patch metadata records review status

### merge_patch

Intent:

Merge reviewed low- and medium-risk project updates into the formal ledger.

Command:

```bash
flg merge --patch .flg/patches/<patch_file>.md
```

Expected result:

- progress is appended to `PROGRESS.md`
- merge log is created
- pending patch is marked as merged

### resume_project

Intent:

Recover project state for a later OpenClaw session.

Command:

```bash
flg status
flg handoff
```

Expected result:

- OpenClaw can summarize current project state
- user does not need to restate project context

## OpenClaw Agent Policy

OpenClaw should follow these rules:

1. Save raw session material before calling closeout.
2. Do not feed `PROGRESS.md`, `SNAPSHOT.md`, or `DECISIONS.md` back into closeout.
3. Do not treat candidate decisions as formal facts before review.
4. Always show pending decisions to the user before merge.
5. On resume, read formal ledger and pending patches.

## Demo Implementation Shortcut

For the first demo, the adapter can be represented by a scripted workflow that OpenClaw triggers step by step.

The competition proof point is that OpenClaw operates the workflow and FlowGrid creates durable local project state.
