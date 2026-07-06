# Local Demo Execution Report — 2026-07-06

## Status

Local demo passed on Windows 11 using Git for Windows Bash.

This means the competition demo path is now recordable.

## Environment

- OS: Windows 11, NT 10.0.26200, x64
- Host: 夕颜baby
- Python: 3.11.9 from `python --version`
- pip: 25.0.1, pointing to Python 3.12 site-packages
- git: 2.53.0.windows.1
- flg version: FlowGrid v0.2.2

Note:

The machine has Python 3.11 and 3.12. FlowGrid was installed into Python 3.12 because `pip` points to Python 3.12. This did not block the demo because `flg version` and the demo script both passed.

## Repositories

- FlowGrid path: `C:\Users\夕颜\.openclaw\workspace\FlowGrid\`
- flowgrid-openclaw path: `C:\Users\夕颜\.openclaw\workspace\flowgrid-openclaw\`

Both repositories were cloned successfully.

## Commands Run

```powershell
pwd
python --version
pip --version
git --version
```

```powershell
cd C:\Users\夕颜\.openclaw\workspace
git clone https://github.com/dlxeva/FlowGrid.git
git clone https://github.com/dlxeva/flowgrid-openclaw.git
```

```powershell
cd FlowGrid
pip install -e .
flg version
```

```powershell
cd C:\Users\夕颜\.openclaw\workspace\flowgrid-openclaw
& "C:\Program Files\Git\bin\bash.exe" scripts/run_local_demo.sh
```

```powershell
cd .demo-runtime\ai-collaboration-sharing
flg status
flg handoff
```

## Result

- [x] FlowGrid installed
- [x] `flg version` passed
- [x] `scripts/run_local_demo.sh` passed with exit code 0
- [x] raw session copied
- [x] closeout patch generated
- [x] decisions reviewed
- [x] patch merged
- [x] handoff output generated

## Generated Evidence

```text
C:\Users\夕颜\.openclaw\workspace\flowgrid-openclaw\.demo-runtime\ai-collaboration-sharing\
├── PROJECT.md
├── FRAMING.md
├── SNAPSHOT.md
├── DECISIONS.md
├── PROGRESS.md
├── GOAL_EVOLUTION.md
├── CONSTRAINTS.md
├── ANCHORS.md
├── LESSONS_LEARNED.md
├── RATIONALE_TRAIL.md
└── .flg/
    ├── state.json
    ├── index.json
    ├── CONTRACT.md
    ├── sessions/session-001.md
    ├── patches/closeout-20260706-234808-8c4a92.patch.md
    └── merge_logs/2026-07-06T23-48-11-merge.md
```

Evidence detail:

- `.flg/sessions/session-001.md`: raw session source
- `.flg/patches/closeout-20260706-234808-8c4a92.patch.md`: generated closeout patch
- `DECISIONS.md`: reviewed decision written into formal ledger
- `PROGRESS.md`: merged session progress
- `.flg/merge_logs/2026-07-06T23-48-11-merge.md`: merge evidence

## Confirmed Demo Path

```powershell
cd C:\Users\夕颜\.openclaw\workspace\flowgrid-openclaw
& "C:\Program Files\Git\bin\bash.exe" scripts/run_local_demo.sh
```

This command is the recommended Windows recording command.

Do not use `C:\Windows\System32\bash.exe`; it is the WSL launcher and may fail if WSL is not configured.

## Observed Non-Blocking Issue

After `flg merge`, `flg status` shows the patch status as `merged`, but the project still reports pending patches because `state.json` retains the merged patch inside the `pending_patches` array.

Observed behavior:

- actual ledger files are correct
- `DECISIONS.md` contains the accepted decision
- `PROGRESS.md` contains the merged session progress
- merge log exists
- `flg status` / `flg handoff` can still mention pending patches because of stale state metadata

Impact:

This is a UI / summary-state inconsistency. It does not block the demo recording.

Recommended fix:

Patch FlowGrid core so merged patches are removed from `pending_patches`, or make status/handoff filter out patches with status other than `pending`.

## Recording Readiness

The local demo is ready for rough recording.

Recommended recording evidence:

1. OpenClaw or OpenCore as the local host/operator.
2. Git for Windows Bash running `scripts/run_local_demo.sh`.
3. Generated ledger files in `.demo-runtime/ai-collaboration-sharing/`.
4. `DECISIONS.md` after review.
5. `PROGRESS.md` after merge.
6. `flg handoff` output.

## Files Changed During Local Execution

No repository source files were changed during local execution.

Only clone directories and `.demo-runtime/` output were created locally.
