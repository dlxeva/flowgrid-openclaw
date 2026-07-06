# OpenClaw Framework Alignment

## Purpose

This document translates OpenClaw framework capabilities into competition-facing proof points for FlowGrid for OpenClaw.

The goal is to make sure the demo is evaluated as an OpenClaw application, not as a standalone FlowGrid CLI demo.

## OpenClaw Capability Map

### 1. Gateway as Control Plane

OpenClaw positions Gateway as the control plane for sessions, channels, tools, and events.

FlowGrid alignment:

- Gateway is the visible operator that receives user intent.
- Gateway routes the task to the Project State Agent.
- The Project State Agent calls FlowGrid tools.
- The resulting project state is persisted locally.

Demo proof:

- show OpenClaw running as the assistant host
- show the project-state workflow being triggered from OpenClaw
- show local files changing after the workflow

### 2. Sessions and Session History

OpenClaw has session primitives and session history.

FlowGrid alignment:

- raw work sessions are preserved under `.flg/sessions/`
- sessions become auditable source material
- session closeout creates reviewable project-state patches

Demo proof:

- show `.flg/sessions/session-001.md`
- show `flg closeout` consuming that session
- show generated patch under `.flg/patches/`

### 3. Tools / Skills Integration Surface

OpenClaw supports tools and workspace skills.

FlowGrid alignment:

- FlowGrid commands are exposed as OpenClaw-callable tools
- the adapter maps project-state intents to `flg` commands
- a future workspace skill can package this behavior cleanly

Demo proof:

- show `openclaw_app/tools/flowgrid_adapter.md`
- show commands triggered in sequence
- show expected output files

### 4. Multi-Agent Routing

OpenClaw supports routing work to isolated agents and sessions.

FlowGrid alignment:

- v0 uses one Project State Agent
- later versions can split capture, review, and resume responsibilities
- FlowGrid ledger gives all agents a shared source of project truth

Demo proof for v0:

- mention this as extensibility, not as already implemented
- avoid overclaiming multi-agent orchestration before runtime proof

### 5. Sandbox and Approval Boundaries

OpenClaw includes sandbox and approval boundary concepts for safer execution.

FlowGrid alignment:

- FlowGrid itself uses a review boundary for project truth
- candidate decisions stay pending before user confirmation
- merge happens after explicit acceptance

Demo proof:

- show candidate decisions before review
- show `DECISIONS.md` only changes after `flg review`
- show merge as a separate step

## Competition Scoring Translation

### Creativity and Innovation

Claim:

FlowGrid introduces a project-state ledger for OpenClaw, turning AI work from single-turn task execution into resumable collaboration.

### OpenClaw Framework Application

Claim:

OpenClaw is used as the visible host, workflow operator, and tool-calling layer. FlowGrid is the local project-state protocol called by OpenClaw.

### Practicality

Claim:

The demo addresses a common real problem: knowledge workers lose project context across AI sessions.

### Completeness

Claim:

The submission includes a runnable local demo, explicit command adapter, workflow documentation, sample session, and generated project-state evidence.

## Red Lines

Do not claim:

- full OpenClaw plugin packaging is complete
- multi-agent orchestration is implemented if the demo only uses one agent
- visual review UI exists before it is built
- FlowGrid replaces OpenClaw

Do claim:

- OpenClaw is the competition-facing host
- FlowGrid adds a project-state layer
- review boundaries preserve human control
- local ledger files make the work resumable
