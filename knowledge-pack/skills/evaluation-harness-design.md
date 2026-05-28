# Skill: Evaluation Harness Design

## purpose

构建通过 controlled rollouts、traces、graders、regression feedback 评估 model-harness pair 的 evaluation harness。

## when_to_use

- benchmark agents。
- 修改 prompt、tool、memory、sandbox、orchestration 或 policy。
- 调查 regression。
- 准备 deployment gates。

## when_not_to_use

- 纯主观 brainstorming。
- 明确要求固定 harness 的 model-only comparison。

## constraints

- evaluation 必须记录 harness configuration。
- final success rate 不足以做结论。
- evaluators 和 graders 必须 versioned。
- nondeterminism 显著时需要 repeated rollouts。
- 生产推广需要 regression tests，不接受一次性 demo。

## execution_steps

1. 定义 task、environment、constraints、allowed tools、success predicates、stop conditions。
2. readiness validation：sandbox、dependencies、tools、context、memory、permissions、budgets、grader。
3. 运行 controlled rollouts 并捕获 trace。
4. 评估 outcome、trajectory、evaluator reliability、cost、latency、policy compliance。
5. 将 failure 归因到可能的 ETCLOVG layers。
6. 将失败转为 regression cases。
7. 用 success-cost-latency-risk frontier 比较 variants。

## validation_rules

- 第三方可复现 evaluation configuration。
- failure report 说明可能 layer 和 evidence。
- grader 稳定性足以支撑决策。
- quality 旁边报告 cost 和 latency。
- benchmark tasks 不通过 memory/context 泄露 hidden state。

## failure_handling

- grader flaky：先修 grader 再评分。
- environment setup 失败：归类为 readiness failure，不算 agent failure。
- score variance 大：增加 run 数并报告 variance。
- agent 不安全成功：标为 failure 或 policy violation。

## examples

- tool schema 的 unit-like test。
- tool selection 的 single-step eval。
- coding issue resolution 的 full rollout。
- context drift 的 multi-turn simulation。
