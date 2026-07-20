# FlowGrid for OpenClaw

> 面向知识工作者的可续接项目状态智能体。

FlowGrid for OpenClaw 是为 Super Claw / OpenClaw 比赛准备的参赛项目。它把 OpenClaw 从一次性任务执行宿主，扩展成可以持续保存项目状态、决策链、风险、下一步动作的本地知识工作智能体。

## 参赛定位

- 作品名称：FlowGrid for OpenClaw
- 推荐赛道：高效学习与创作
- 核心技术载体：OpenClaw
- 核心协议层：FlowGrid
- 目标用户：创作者、研究者、策略人员、运营人员、解决方案人员

## 要解决的问题

AI 辅助知识工作经常出现状态断裂：

- 决策散落在聊天记录里
- 放弃过的方案和判断依据无法追溯
- 下一次会话需要重新解释项目背景
- 不同 Agent 接力时看不到完整上下文
- 用户很难区分正式项目事实和待确认的 AI 建议

## 核心方案

FlowGrid for OpenClaw 为 OpenClaw 增加一个本地项目状态层：

- 将原始工作会话保存到 `.flg/sessions/`
- 将会话收尾为可审核 patch
- 抽取候选决策、风险、开放问题和下一步动作
- 由用户确认后写入 `DECISIONS.md`
- 合并到正式项目账本
- 下次会话从 `SNAPSHOT.md`、`DECISIONS.md` 和 pending patches 恢复状态

## 最小演示闭环

1. 用户在 OpenClaw 中启动一个创作或方案项目。
2. OpenClaw 调用 FlowGrid 初始化本地项目账本。
3. 用户自然讨论项目目标、约束、判断和下一步。
4. OpenClaw 通过 JSONL 工具适配器保存原始 session。
5. OpenClaw 调用 `flg closeout` 生成待审核 patch。
6. 演示使用明确的 `accept_all` 模式，并将结果标为 medium authority；生产宿主应在自己的 UI 中提供审核。
7. OpenClaw 调用 `flg review` 和 `flg merge`。
8. 新会话从本地文件恢复项目状态，并写入可检查的 tool trace。

## 本地验证

本地 demo 已在 Windows 11 + Git for Windows Bash 环境跑通。

推荐 Windows 录制命令：

```powershell
cd C:\Users\夕颜\.openclaw\workspace\flowgrid-openclaw
& "C:\Program Files\Git\bin\bash.exe" scripts/run_local_demo.sh
```

macOS / Linux / Git Bash：

```bash
bash scripts/run_local_demo.sh
```

本地运行会在 `.demo-runtime/ai-collaboration-sharing/` 下生成一套可检查的项目账本、session、patch、decision log、progress log、handoff 输出和 `openclaw-tool-trace.jsonl`。脚本会断言 session、confirmed evidence、merged patch 和完整六步工具轨迹均存在。

演示依赖的 FlowGrid 版本与提交记录在 [`flowgrid-core.lock`](flowgrid-core.lock)。传入 `FLOWGRID_REPO=/path/to/FlowGrid` 时，脚本会同时校验 Git SHA；不传时至少校验 CLI 版本。

## 仓库结构

```text
flowgrid-openclaw/
├── README.md
├── docs/
│   ├── architecture.md
│   ├── demo-script.md
│   ├── execution-plan.md
│   ├── local-execution-report-2026-07-06.md
│   ├── local-operator-steps.md
│   ├── openclaw-framework-alignment.md
│   ├── recording-plan-after-local-pass.md
│   ├── recording-runbook.md
│   └── submission-checklist.md
├── examples/
│   └── creator-project-demo/
│       ├── README.md
│       └── session-001.md
├── openclaw_app/
│   ├── manifest.json
│   ├── README.md
│   ├── agents/
│   │   └── project_state_agent.md
│   ├── tools/
│   │   ├── flowgrid_adapter.md
│   │   └── flowgrid_adapter.py
│   └── workflows/
│       └── project_state_loop.md
├── scripts/
│   ├── README.md
│   └── run_local_demo.sh
└── assets/
    └── README.md
```

## 与 FlowGrid 主仓库的关系

`dlxeva/FlowGrid` 是核心协议与 CLI 仓库。

本仓库是比赛交付仓，重点放在 OpenClaw 集成、演示场景、技术说明和提交材料。

## 当前状态

- [x] 新建比赛仓库
- [x] 明确 OpenClaw-first 参赛定位
- [x] 补 OpenClaw 集成架构文档
- [x] 补 OpenClaw 框架对齐文档
- [x] 补演示脚本文档
- [x] 补录制 runbook
- [x] 补样例项目说明和 raw session
- [x] 补本地 demo 脚本
- [x] 本机运行验证 demo 脚本
- [x] 补本地执行报告
- [x] 补录制计划
- [ ] 录制本地运行视频
- [ ] 最终检查参赛 PPT / PDF
