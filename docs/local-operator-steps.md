# Local Operator Steps

## Purpose

Some work must be done on the user's local machine because the competition requires local runtime and screen-recording evidence.

This document keeps the local operator workload minimal.

## What the AI Lead Can Do Remotely

- maintain repository structure
- write documentation
- prepare demo scripts
- prepare PPT outline and script
- inspect GitHub files
- update issues and execution plan
- define acceptance criteria

## What Must Be Done Locally

- install and run OpenClaw / Gateway
- install FlowGrid as the local `flg` command
- run the local demo script
- verify generated files
- record the screen for the final competition video

## Minimum Local Command Sequence

### 1. Clone repositories

```bash
git clone https://github.com/dlxeva/FlowGrid.git
git clone https://github.com/dlxeva/flowgrid-openclaw.git
```

### 2. Install FlowGrid

```bash
cd FlowGrid
pip install -e .
flg version
```

### 3. Run the competition demo script

macOS / Linux / Git Bash:

```bash
cd ../flowgrid-openclaw
bash scripts/run_local_demo.sh
```

Windows PowerShell with Git for Windows:

```powershell
cd C:\Users\夕颜\.openclaw\workspace\flowgrid-openclaw
& "C:\Program Files\Git\bin\bash.exe" scripts/run_local_demo.sh
```

Do not use `C:\Windows\System32\bash.exe` for this demo. That path launches WSL and may fail when WSL is not configured.

### 4. Check generated evidence

macOS / Linux / Git Bash:

```bash
ls -la .demo-runtime/ai-collaboration-sharing
ls -la .demo-runtime/ai-collaboration-sharing/.flg/patches
cat .demo-runtime/ai-collaboration-sharing/DECISIONS.md
cat .demo-runtime/ai-collaboration-sharing/PROGRESS.md
```

Windows PowerShell:

```powershell
Get-ChildItem .demo-runtime\ai-collaboration-sharing
Get-ChildItem .demo-runtime\ai-collaboration-sharing\.flg\patches
Get-Content .demo-runtime\ai-collaboration-sharing\DECISIONS.md
Get-Content .demo-runtime\ai-collaboration-sharing\PROGRESS.md
```

Run `flg handoff` from inside:

```bash
cd .demo-runtime/ai-collaboration-sharing
flg handoff
```

## Expected Success Signal

The demo is ready for recording if the script produces:

- project ledger files
- raw session file
- pending patch
- reviewed decisions
- merged progress
- handoff output

## Known Windows Notes

- Python and pip may point to different installed Python versions. The demo is valid as long as `flg version` works and `scripts/run_local_demo.sh` passes.
- Git for Windows Bash is the recommended Bash runtime on Windows.
- The local verified command is: `& "C:\Program Files\Git\bin\bash.exe" scripts/run_local_demo.sh`.

## If It Fails

Copy the terminal error and send it back.

Do not try to redesign the project locally. The AI lead should diagnose the failing command and patch the repository or FlowGrid usage path.
