# OpenClaw App

This directory contains the OpenClaw-side integration layer.

`manifest.json` describes the available tools. `tools/flowgrid_adapter.py`
implements a JSONL-over-stdio command adapter: an OpenClaw tool runner sends
one request object per line and receives one result object per line. The
adapter delegates to the FlowGrid CLI and writes a local audit trace under
`.flg/openclaw-tool-trace.jsonl`.

It deliberately does not claim a proprietary OpenClaw SDK integration. The
competition demo proves a portable tool boundary that OpenClaw can load or
bridge from its own tool runner.
