# Architecture

## 核心判断

FlowGrid for OpenClaw 的架构目标是让 OpenClaw 成为知识工作项目的持续宿主。

用户继续用自然语言工作；OpenClaw 负责判断什么时候调用工具；FlowGrid 负责把项目状态稳定落到本地文件系统。

## 系统分层

```text
User
  ↓ natural language
OpenClaw Host Agent
  ↓ tool calling / workflow control
FlowGrid Tool Adapter
  ↓ CLI invocation
FlowGrid Core Protocol
  ↓ file writes
Local Project Ledger
```

## 关键模块

### 1. OpenClaw Host Agent

职责：

- 接收用户自然语言输入
- 识别项目启动、会话收尾、决策审核、状态恢复等意图
- 调用 FlowGrid 工具适配层
- 将结果解释给用户

### 2. FlowGrid Tool Adapter

职责：

- 封装 `flg init`
- 封装 `flg closeout`
- 封装 `flg review`
- 封装 `flg merge`
- 封装 `flg status` 和 `flg handoff`

### 3. FlowGrid Core Protocol

职责：

- 维护项目账本文件
- 维护 pending patches
- 维护 session artifacts
- 维护 review boundary

### 4. Local Project Ledger

核心文件：

- `PROJECT.md`
- `FRAMING.md`
- `SNAPSHOT.md`
- `DECISIONS.md`
- `PROGRESS.md`
- `.flg/state.json`
- `.flg/patches/`
- `.flg/sessions/`

## OpenClaw 使用重点

比赛版需要突出 OpenClaw 的技术承载关系：

- OpenClaw 是用户交互入口
- OpenClaw 负责 agent workflow 编排
- OpenClaw 通过 tool calling 调用 FlowGrid
- OpenClaw 从本地 ledger 恢复项目上下文
- OpenClaw 在长会话中触发 closeout 或状态同步

## 最小可行技术闭环

```text
start project
  → flg init
work session
  → save raw session file
closeout
  → flg closeout
human review
  → flg review
merge
  → flg merge
resume
  → read ledger + flg handoff
```

## 比赛演示重点

演示时必须看到三件事：

1. 用户在 OpenClaw 中自然工作。
2. OpenClaw 实际调用 FlowGrid 命令。
3. 本地项目文件在会话后发生可解释变化。

## 风险

### OpenClaw 使用深度不足

只展示 CLI 会削弱比赛评分。演示里必须让 OpenClaw 成为可见的宿主。

### 产品被理解成会议纪要工具

演示要强调项目状态、决策链、review boundary 和跨会话续接。

### 本地运行证据不足

视频必须展示项目目录、生成文件、命令执行和新会话恢复过程。
