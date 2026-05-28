# Skill: Lifecycle And Orchestration

## purpose

设计 agent 工作从 planning、execution、validation、failure recovery、handoff 到 completion 的控制流。

## when_to_use

- 任务需要多步、retry、checkpoint 或 human review。
- 多 agent 或跨 session 协调。
- 出现 premature completion、loop、bad handoff。
- 需要 issue-to-PR 或 research-to-artifact 全流程。

## when_not_to_use

- 单个 deterministic tool call 足以完成任务。
- 工作只是临时探索，没有 durable output。

## constraints

- plan 和 progress 必须有 single source of truth。
- ownership boundary 必须明确。
- execution 前定义 stop conditions。
- 只有在降低 context pollution、支持 parallelism 或提供 independent validation 时才加 subagents。
- handoff 必须包含 state、evidence、risks、next action。

## execution_steps

1. 定义 lifecycle stages：intake、plan、execute、verify、review、handoff、close。
2. 选择 orchestration pattern：single loop、workflow、graph、hierarchical、team、fan-out。
3. 定义 state artifacts 和更新点。
4. 定义 retry、checkpoint、timeout、escalation rules。
5. 只在有明确价值时定义 subagent roles。
6. 小步执行。
7. 每阶段转换前验证。
8. 只有 completion criteria 和 evidence 满足时 close。

## validation_rules

- 系统可在 interruption 后 resume。
- 每个任务的当前 owner 已知。
- stop conditions 能防 infinite loop。
- handoff 足够另一个 agent 接手。
- 高风险变更的 verification gate 不可跳过。

## failure_handling

- loop：停止并要求 failure attribution。
- premature completion：重开任务并强化 completion criteria。
- bad delegation：缩小 scope 并定义 expected artifact。
- inconsistent state：与 durable source of truth 对账。

## examples

- coding task：issue -> plan -> patch -> tests -> review -> PR notes。
- research task：question -> source registry -> evidence extraction -> synthesis -> review。
- multi-agent task：orchestrator 管 plan；workers 管不重叠 scope。
