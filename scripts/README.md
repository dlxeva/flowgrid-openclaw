# Scripts

## run_local_demo.sh

Runs the local FlowGrid demo loop used by the OpenClaw competition submission.

Prerequisite:

```bash
flg version
```

If `flg` is not available, install the FlowGrid core repository first:

```bash
pip install -e /path/to/FlowGrid
```

Run:

```bash
bash scripts/run_local_demo.sh
```

Expected output:

- `.demo-runtime/ai-collaboration-sharing/PROJECT.md`
- `.demo-runtime/ai-collaboration-sharing/DECISIONS.md`
- `.demo-runtime/ai-collaboration-sharing/PROGRESS.md`
- `.demo-runtime/ai-collaboration-sharing/SNAPSHOT.md`
- `.demo-runtime/ai-collaboration-sharing/.flg/patches/`

Use this script to verify the FlowGrid side of the OpenClaw demo before recording the final video.
