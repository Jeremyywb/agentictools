# Verification Policy

## 强约束

1. 声称完成前必须验证。
2. 验证必须匹配风险：低风险用 targeted check，高风险用 layered eval。
3. Final score 不足以证明 harness 可靠。
4. Evaluation 必须记录 model-harness configuration。
5. Grader 和 judge prompt 必须 versioned。
6. Flaky evaluator 必须先修复或标注，不得直接用于结论。
7. 成本、延迟、token、tool call count 是评估指标。
8. 安全策略违反即使 outcome 正确也不能算成功。
9. 生产 failure trace 应转为 regression case。
10. 验证不完整时必须记录 residual risk。

## 验证层级

- Unit-like：schema、validators、policy predicates。
- Single-step：tool selection、retrieval、permission decision。
- Full-turn：完整 observe-act-observe。
- Full-rollout：任务端到端完成。
- Trajectory：路径效率、安全、恢复、成本。
- Evaluator-level：grader 稳定性、bias、version。
- Regression：对历史失败和生产 trace 的防回归。

## 完成输出

- 已运行检查。
- 结果。
- 失败或跳过原因。
- trace/test IDs。
- 结论可信度。
- residual risks。

## 来源

S0, S11, S16, S20, P2, P3, P8。
