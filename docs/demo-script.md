# Demo Script

目标视频长度：3 到 5 分钟。

目标观众：比赛评委。

核心信息：OpenClaw 作为智能体宿主，调用 FlowGrid，把一次性 AI 对话变成可续接的项目状态。

## 0:00 - 0:20 痛点开场

画面：展示一个普通 AI 对话窗口或历史聊天列表。

讲法：

> 很多 AI 协作的问题不在于生成能力，而在于项目状态无法持续。上一次做过的判断、放弃过的方案、下一步动作，常常散落在聊天记录里。下一次再打开时，用户又要重新解释项目背景。

## 0:20 - 0:50 项目启动

画面：OpenClaw 中启动 FlowGrid 项目。

操作：

```bash
flg init "Creator Project Demo" --type proposal --client "Demo User"
```

讲法：

> 在这个 demo 里，OpenClaw 作为用户的工作入口。用户只需要自然描述项目，OpenClaw 在合适的时候调用 FlowGrid 初始化本地项目账本。

展示文件：

- `PROJECT.md`
- `FRAMING.md`
- `SNAPSHOT.md`
- `DECISIONS.md`
- `PROGRESS.md`
- `.flg/`

## 0:50 - 1:40 自然工作会话

画面：用户在 OpenClaw 中讨论一个内容创作或方案项目。

示例输入：

> 我想做一个关于 AI 协作方式升级的分享，目标用户是已经用过 AI 工具但还没有形成项目化协作方法的人。帮我一起梳理定位、痛点和第一版结构。

OpenClaw 应该产出：

- 项目目标
- 目标用户
- 当前痛点
- 备选表达方向
- 下一步动作

讲法：

> 这里的关键不是生成一篇完整文章，而是把讨论过程中的判断保存下来。

## 1:40 - 2:20 会话收尾

画面：OpenClaw 保存原始 session，然后调用 closeout。

操作：

```bash
flg closeout --transcript .flg/sessions/demo-session-001.md
```

讲法：

> 会话结束时，OpenClaw 把原始讨论保存到 sessions 目录，再调用 FlowGrid 生成 closeout patch。这个 patch 还不是正式事实，需要用户审核。

展示内容：

- candidate decisions
- risks
- open questions
- next actions
- patch 文件路径

## 2:20 - 3:00 决策审核与合并

操作：

```bash
flg review --patch .flg/patches/<patch-file>.md
flg merge --patch .flg/patches/<patch-file>.md
```

讲法：

> FlowGrid 不让 AI 把候选判断直接写成正式项目事实。候选决策要经过用户确认，再进入 DECISIONS.md。这样可以保留 AI 协作效率，同时保留人的最终审稿权。

展示文件：

- `DECISIONS.md`
- `PROGRESS.md`
- merge log

## 3:00 - 4:00 新会话恢复

画面：开启一个新的 OpenClaw 会话。

操作：

```bash
flg status
flg handoff
```

讲法：

> 下次用户回来时，OpenClaw 不需要让用户重新解释。它读取本地账本、决策日志和 pending patches，就能恢复当前项目状态。

展示恢复摘要：

- 当前目标
- 已确认决策
- 当前风险
- 下一步动作

## 4:00 - 4:40 总结亮点

讲法：

> FlowGrid for OpenClaw 的价值，是把 OpenClaw 从任务执行工具扩展成持续项目协作宿主。它适合创作、研究、方案、复盘等判断型知识工作，因为这些工作最怕丢失上下文和决策链。

## 必须录到的证据

- OpenClaw 交互画面
- `flg` 命令执行过程
- `.flg/sessions/` 中的原始 session
- `.flg/patches/` 中的 pending patch
- `DECISIONS.md` 被 review 后更新
- 新会话通过 `flg handoff` 恢复项目状态
