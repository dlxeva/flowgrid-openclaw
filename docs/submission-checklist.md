# Submission Checklist

## 基本信息

- [ ] 作品名称：FlowGrid for OpenClaw
- [ ] 参赛赛道：高效学习与创作
- [ ] 仓库地址：确认公开可访问
- [ ] 团队信息：补充成员、联系方式、分工
- [ ] 开源协议：确认 LICENSE

## 技术实现

- [ ] OpenClaw 可以作为可见交互宿主运行
- [ ] OpenClaw 可以调用 FlowGrid 命令
- [ ] 可以初始化本地 FlowGrid 项目
- [ ] 可以保存原始 session 到 `.flg/sessions/`
- [ ] 可以运行 `flg closeout`
- [ ] 可以展示 pending patch
- [ ] 可以运行 `flg review`
- [ ] 可以运行 `flg merge`
- [ ] 可以通过 `flg handoff` 恢复项目状态

## 本地演示材料

- [ ] 准备一个稳定 demo 项目
- [ ] 准备一段原始 session 示例
- [ ] 准备 closeout 后的 patch 示例
- [ ] 准备 review 后的 `DECISIONS.md` 示例
- [ ] 准备 resume 阶段的 handoff 输出

## 视频材料

- [ ] 视频长度控制在 3 到 5 分钟
- [ ] 分辨率不低于 1080P
- [ ] 格式为 MP4
- [ ] 文件大小控制在 300MB 内
- [ ] 包含 OpenClaw 交互画面
- [ ] 包含本地运行画面
- [ ] 包含核心功能操作
- [ ] 包含创意亮点讲解
- [ ] 包含稳定性验证

## PPT 材料

建议页数：10 到 12 页。

- [ ] 封面：FlowGrid for OpenClaw
- [ ] 痛点：AI 协作项目状态断裂
- [ ] 场景：创作者 / 研究者 / 策略人员跨会话工作
- [ ] 方案：OpenClaw + FlowGrid 本地项目状态层
- [ ] 核心流程：start / session / closeout / review / merge / resume
- [ ] 技术架构：OpenClaw host agent + FlowGrid adapter + local ledger
- [ ] OpenClaw 使用深度：workflow、tool calling、memory、session handoff
- [ ] 创新点：review boundary、pending facts、decision continuity
- [ ] Demo 截图：本地文件变化和恢复过程
- [ ] 当前完成度：已实现 / 待完善
- [ ] 路线图：视觉 review、更多模板、多 Agent 审核
- [ ] 团队信息

## 评分对齐

### 创意创新性

- [ ] 强调项目状态层
- [ ] 强调决策链保存
- [ ] 强调跨会话恢复
- [ ] 强调 AI 建议先审核再入账

### OpenClaw 框架应用能力

- [ ] OpenClaw 是主交互入口
- [ ] OpenClaw 调用 FlowGrid 工具
- [ ] OpenClaw 管理工作流顺序
- [ ] OpenClaw 可读取本地项目状态

### 实用性和场景贴合度

- [ ] 使用真实知识工作场景
- [ ] 场景避免泛泛会议纪要
- [ ] 展示用户能直接理解的收益

### 完整度和稳定性

- [ ] 本地部署可复现
- [ ] 视频里可看到完整闭环
- [ ] 仓库结构清晰
- [ ] README 可让评委快速理解

## 当前风险

### OpenClaw 集成深度不足

处理方式：至少完成一个可见的 OpenClaw host workflow，避免只展示 FlowGrid CLI。

### Demo 过于抽象

处理方式：固定一个创作者方案项目，用具体输入、具体文件、具体决策来演示。

### 时间不足

处理方式：先保证可跑闭环，再补视觉和包装。PPT 服从 demo，不先做空概念包装。
