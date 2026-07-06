# Execution Plan

## Owner Mode

This repository is now managed as a competition delivery project.

The owner objective is not to produce a broad open-source framework. The objective is to produce a demonstrable OpenClaw-first competition submission before the deadline.

## Primary Deliverable

A working demo showing:

1. OpenClaw as the visible user-facing host.
2. FlowGrid as the local project-state protocol layer.
3. A complete loop from project start to session closeout, human review, merge, and later resume.

## Non-Negotiable Direction

For the competition submission, OpenClaw is the core technical carrier.

Codex and Hermes remain useful internal development and dogfood hosts, but they must not be the main subject of the competition-facing story.

## OpenClaw Anchors

The demo should lean on OpenClaw capabilities that are visible and explainable:

- Gateway as the local-first control plane
- agent command execution
- sessions and session history
- tools / skills as the integration surface
- multi-agent routing where practical
- sandbox and approval boundaries where relevant

## Working Thesis

FlowGrid for OpenClaw is valuable because OpenClaw can already act as a persistent personal AI assistant. FlowGrid gives it a project-state ledger for judgment-heavy knowledge work.

This turns OpenClaw from an always-on assistant into a resumable project collaborator.

## Scope for Version 0

### Must Have

- OpenClaw-facing README and architecture docs
- one stable demo scenario
- FlowGrid command adapter design
- scriptable local demo loop
- visible generated project files
- video script and submission checklist

### Should Have

- minimal OpenClaw workflow wrapper
- tool adapter examples
- sample `.flg/sessions/` input
- sample closeout patch
- sample reviewed `DECISIONS.md`

### Can Defer

- visual review UI
- multi-user collaboration
- full plugin marketplace packaging
- complex multi-agent orchestration
- polished product website

## Immediate Work Queue

### Phase 1: Demo Skeleton

Goal: create a runnable, inspectable local demo path.

Tasks:

- define OpenClaw-to-FlowGrid tool adapter commands
- create sample session file
- create demo runbook
- define expected output files

### Phase 2: OpenClaw Host Loop

Goal: make OpenClaw visibly responsible for the workflow.

Tasks:

- wrap `flg init`
- wrap `flg closeout`
- wrap `flg review`
- wrap `flg merge`
- wrap `flg handoff`
- document each step as OpenClaw-triggered

### Phase 3: Submission Package

Goal: produce final competition materials.

Tasks:

- record 3-5 minute demo video
- create 10-12 page PPT
- export PPT to PDF
- finalize repository README
- verify public access

## Risk Register

### Risk 1: OpenClaw usage appears superficial

Mitigation:

The demo must show OpenClaw as the actual operator, not just FlowGrid CLI running in a terminal.

### Risk 2: Project gets mistaken for a meeting-summary tool

Mitigation:

Use decision continuity, review boundary, pending patches, and resume behavior as the main story.

### Risk 3: Time spent on packaging before runtime proof

Mitigation:

No final PPT polishing until the demo path is runnable or at least scriptably reproducible.

### Risk 4: Main FlowGrid repo gets distorted by competition needs

Mitigation:

Keep `dlxeva/FlowGrid` as the core protocol repo. Keep this repository as the OpenClaw competition delivery repo.

## Current Priority

Build `openclaw_app/tools/flowgrid_adapter.md` and `examples/creator-project-demo/session-001.md` next.

Those two files will turn the current documentation skeleton into a concrete demo implementation target.
