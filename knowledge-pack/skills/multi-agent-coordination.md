# Skill: Multi-Agent Coordination

## purpose

协调多个 agents/subagents，同时保持 ownership、context isolation、verification 和安全 handoff。

## when_to_use

- 工作能拆成独立 subtasks。
- parallel exploration 能提升覆盖。
- reviewer/evaluator 需要独立。
- 详细探索会污染 orchestrator context。

## when_not_to_use

- 下一步是 orchestrator 必须亲自解决的 blocking task。
- subtasks 共享 write scope 且没有 merge protocol。
- coordination overhead 大于预期收益。

## constraints

- orchestrator 拥有 objective、plan、integration、final decision。
- subagent 必须有 bounded scope 和 expected output。
- write scopes 不重叠，除非有协调规则。
- subagent 返回 evidence，而不是只给结论。
- handoff summary 必须包含 risk 和 verification status。

## execution_steps

1. 说明为什么需要 multi-agent。
2. 拆分 independent scopes。
3. 给每个 agent 分配 role、inputs、constraints、ownership、output format。
4. 定义 shared artifacts 和 conflict rules。
5. 只在 scope 不冲突时并行。
6. 带 source review 集成输出。
7. 验证组合结果。
8. 记录 handoff 和 residual risk。

## validation_rules

- 每个 subtask 都实质推进目标。
- 没有两个 agents 无意识编辑同一 scope。
- 返回 evidence 足够 integration。
- orchestrator 验证最终状态。
- multi-agent costs 和 failures 被测量。

## failure_handling

- subagent 输出模糊：要求 evidence 或本地重做。
- outputs 冲突：优先可验证来源并运行 targeted checks。
- coordination state diverges：暂停集成，与 durable artifacts 对账。
- overhead 占主导：简化为 single-agent workflow。

## examples

- research：source discovery、paper extraction、critique 分开。
- coding：worker A 管 backend file，worker B 管 tests，reviewer 管 findings。
- evaluation：implementer 不能单独判定完成。
