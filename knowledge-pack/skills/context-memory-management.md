# Skill: Context And Memory Management

## purpose

让模型 active context 保持小、相关、与 durable task state 对齐，并支持跨 turn / 跨 session 延续。

## when_to_use

- 长任务超过单个 context window。
- agent 重复工作、忘约束、前后矛盾。
- tool outputs 占满上下文。
- 需要跨 session continuity。

## when_not_to_use

- 短小无状态任务。
- 所有必要信息都能稳定、低成本放入 prompt。

## constraints

- active context 不是事实来源。
- task state 必须持久化到外部 artifact。
- memory 应包含 provenance、timestamp、confidence。
- summary 必须保留 decisions、constraints、unresolved issues、evidence。
- 未验证幻觉不得持久化。

## execution_steps

1. 将信息分类为 active context、session state、long-term memory。
2. 只预加载总是需要的 instructions 和 state。
3. 条件性信息 just-in-time retrieve。
4. 大型 tool output 用完后替换为 compact reference。
5. 维护 progress notes、plans、handoff files。
6. 需要 compaction 时先保证 recall，再逐步去噪。
7. critical action 前用 durable artifacts 校验 memory。
8. 定期审计 stale 或 contradictory memory。

## validation_rules

- agent 可从 durable artifacts 重启。
- 当前 objective 和 constraints 可见。
- 每个大型 context entry 都有存在理由。
- memory entries 包含 provenance 和 confidence。
- summary 足够另一个 agent 接手。

## failure_handling

- context lost：从 source files、traces、progress docs、tests 重建。
- memory 与 source of truth 冲突：优先 source of truth，标记 memory stale。
- retrieval miss：改进 indexing、metadata 或 query strategy。
- compaction loss：从 pre-compaction trace 或 durable artifacts 恢复。

## examples

- implementation decisions 写入 `PROGRESS.md`，不要只留在 chat。
- context 保留 file paths，按需读取内容。
- 新错误匹配旧 failure signature 时检索历史失败记录。
