# Checklist: Innovation Readiness

## Hypothesis

- [ ] 假设可证伪。
- [ ] target ETCLOVG layer 明确。
- [ ] 预期改善的 metric 明确。
- [ ] 机制解释明确。

## Baseline

- [ ] baseline model 记录。
- [ ] harness version 记录。
- [ ] prompt/tool/context/sandbox/policy/evaluator 记录。
- [ ] baseline metrics 已有。

## Variant

- [ ] 实现可回滚。
- [ ] 有 feature flag 或隔离路径。
- [ ] trace labels 明确。
- [ ] 不破坏既有 policy。

## Evaluation

- [ ] unit/single-step/full-rollout 计划明确。
- [ ] trajectory evaluation 明确。
- [ ] adversarial/stress cases 明确。
- [ ] cost/latency/risk guardrails 明确。

## Promotion

- [ ] improvement 可重复。
- [ ] 不是 benchmark artifact。
- [ ] safety/governance 不退化。
- [ ] rollback path 已测试。
- [ ] failure modes 已记录。
