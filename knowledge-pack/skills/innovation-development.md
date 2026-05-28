# Skill: Innovation Development

## purpose

把新的 harness 想法转化为带 hypothesis、guardrails、traces、promotion gates 的受控实验。

## when_to_use

- 提出新的 harness mechanism。
- 新增 orchestration、memory、tool routing、sandbox、governance 或 evaluation 行为。
- 想改善 quality、cost、latency、safety、scalability。

## when_not_to_use

- 原因和方案都明确的 routine bug fix。
- 纯 cosmetic change。
- 不能评估或不能回滚的想法。

## constraints

- 每个创新必须有可证伪 hypothesis。
- 必须在可回滚 flag 或隔离路径后实现。
- baseline 与 variant 必须可比较。
- promotion 需要 outcome、trajectory、cost、latency、risk 全面证据。
- 不得在没有明确风险接受的情况下弱化 governance。

## execution_steps

1. 写 hypothesis 和 target ETCLOVG layer。
2. 定义 baseline harness configuration。
3. 定义 metrics 和 guardrails。
4. 实现最小可回滚 variant。
5. 运行 layered evaluation：unit、single-step、rollout、trajectory、adversarial/stress。
6. 分析 trace evidence 和 failure attribution。
7. 决策：reject、revise、shadow、limited rollout、promote。
8. 记录经验并移除过时 scaffold。

## validation_rules

- hypothesis 可被证伪。
- improvement 不是只来自 benchmark 或轶事。
- variant 有 trace labels。
- failure modes 已记录。
- rollback path 已测试。

## failure_handling

- 结果不清：先做 ablation，不推广。
- cost/latency 变差：需要显式 tradeoff decision。
- safety regression：reject 或 redesign。
- 收益依赖狭窄 benchmark artifact：不得泛化。

## examples

- 测试 subagent context isolation 是否改善仓库探索。
- 测试 signed MCP tool descriptors 是否降低 tool-integrity risk。
- 测试 uncertainty-tagged compaction summaries 是否改善长任务恢复。
