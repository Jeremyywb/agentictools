# Orchestration Rules

## 核心规则

1. Orchestrator 拥有最终目标、计划、集成和完成判断。
2. 每个 agent/subagent 必须有清晰 role、scope、inputs、outputs、constraints、validation。
3. 不要把下一步立即依赖的 blocking task 委派出去后空等。
4. 并行只用于不冲突的独立工作。
5. 多 agent 必须有 single source of truth：计划、进度、状态、所有权。
6. Handoff 必须包含 objective、completed work、remaining work、evidence、risks、verification status、next action。
7. Evaluator/reviewer 必须与 implementer 有足够独立性。
8. 对复杂任务优先 workflow/graph/sprint/checkpoint，而不是无边界 autonomous loop。
9. 每个 loop 必须有 stop condition、budget、retry policy、escalation condition。
10. 多 agent 成本、延迟和协调失败必须进入 evaluation。

## 何时使用 multi-agent

可以使用：

- 并行探索能缩短时间。
- 子任务上下文会污染主上下文。
- 需要独立评估或红队。
- 任务天然分工明确。

不应使用：

- 单 agent 可直接完成。
- write scope 冲突且无 merge protocol。
- 只为了“看起来更智能”。
- orchestrator 不能验证 subagent 输出。

## 常见失败

- Planner 过度拆分，导致协调成本超过收益。
- Worker 输出结论但没有证据。
- Reviewer 与 implementer 共用同一盲点。
- Handoff 只写摘要，没有约束和未决问题。
- Fan-out 没有预算，成本指数增长。

## 来源

S0, S6, S8, S10, S12, S13, S17, S19。
