# Recording Runbook

## Purpose

This runbook defines the exact recording path for the competition demo video.

Target length: 3 to 5 minutes.

The video must show FlowGrid for OpenClaw as an OpenClaw-hosted project-state workflow, not as a standalone CLI utility.

## Recording Setup

Prepare three visible areas:

1. OpenClaw host interface or terminal session where OpenClaw is invoked.
2. Terminal showing FlowGrid commands being triggered.
3. File explorer or editor showing generated project ledger files.

If the first version is script-driven, OpenClaw must still be visible as the operator or narrator that initiates the workflow.

## Scene 1: Problem Setup

Time: 0:00 - 0:25

Show:

- title: FlowGrid for OpenClaw
- one-sentence problem: AI collaboration loses project state between sessions

Voiceover:

> AI agents can complete tasks, but knowledge work often needs project memory. Decisions, rejected options, risks, and next actions disappear into chat history. FlowGrid for OpenClaw turns OpenClaw into a resumable project-state agent.

## Scene 2: OpenClaw Starts the Project

Time: 0:25 - 0:55

Show:

- OpenClaw host interface
- project-start instruction
- `flg init` command being triggered
- generated files

Command evidence:

```bash
flg init "AI Collaboration Sharing" --type proposal --client "Demo User"
```

Must show:

- `PROJECT.md`
- `FRAMING.md`
- `SNAPSHOT.md`
- `DECISIONS.md`
- `.flg/`

## Scene 3: Work Session Capture

Time: 0:55 - 1:30

Show:

- sample user session
- `.flg/sessions/session-001.md`

Voiceover:

> OpenClaw preserves the raw working session before interpretation. This matters because the raw session is the evidence layer. FlowGrid does not treat a summary as truth.

## Scene 4: Closeout Patch

Time: 1:30 - 2:10

Show:

```bash
flg closeout --transcript .flg/sessions/session-001.md
```

Must show:

- `.flg/patches/<patch-file>.md`
- candidate decisions
- risks
- next actions

Voiceover:

> The closeout step converts the session into a pending project-state patch. It is not merged automatically.

## Scene 5: Human Review Boundary

Time: 2:10 - 2:50

Show:

```bash
flg review --patch .flg/patches/<patch-file>.md --accept-all
```

Then show `DECISIONS.md`.

Voiceover:

> Candidate decisions become formal project facts only after review. This is the key boundary between AI assistance and human judgment.

## Scene 6: Merge and Resume

Time: 2:50 - 3:40

Show:

```bash
printf "y\n" | flg merge --patch .flg/patches/<patch-file>.md
flg status
flg handoff
```

Must show:

- `PROGRESS.md`
- merge log
- handoff output

Voiceover:

> A later OpenClaw session can resume from the local ledger. The user does not need to explain the project again.

## Scene 7: OpenClaw Framework Alignment

Time: 3:40 - 4:30

Show a simple architecture diagram or document section.

Mention:

- OpenClaw Gateway as control plane
- sessions as raw evidence
- tools / skills as the FlowGrid adapter surface
- review boundary as human approval layer
- local ledger as durable state

## Scene 8: Closing

Time: 4:30 - 5:00

Voiceover:

> FlowGrid for OpenClaw is designed for creators, researchers, strategists, and operators who work across multiple AI sessions. It gives OpenClaw a durable project-state layer for judgment-heavy knowledge work.

## Recording Checklist

- [ ] Show OpenClaw as host/operator
- [ ] Show `flg init`
- [ ] Show raw session file
- [ ] Show closeout patch
- [ ] Show candidate decisions before review
- [ ] Show `DECISIONS.md` after review
- [ ] Show merge confirmation
- [ ] Show handoff/resume output
- [ ] Show architecture / OpenClaw alignment
- [ ] Keep final video under 5 minutes

## Do Not Show

- long terminal setup
- package installation failures
- unrelated GitHub browsing
- manual explanations without file evidence
- claims of full plugin packaging if not implemented
