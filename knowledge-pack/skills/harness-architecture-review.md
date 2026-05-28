# Skill: Harness Architecture Review

## purpose

按 ETCLOVG 七层审查一个 agent harness，找出可靠性、安全性、评估、扩展性和治理缺口。

## when_to_use

- 评审新的 agent 架构。
- 诊断长程任务反复失败。
- 比较 frameworks、platforms 或 harness variants。
- 为生产级 agent 制定实施计划。

## when_not_to_use

- 没有工具、状态和执行环境的单轮 prompt 调优。
- 故意固定 harness 的纯模型 benchmark。
- 只评审 UI 外观。

## constraints

- 必须使用 ETCLOVG 结构。
- 区分事实、假设、建议。
- 没有 test、trace 或来源文档时，不得声称组件安全或可靠。
- 缺少 observability、evaluation、governance 应视为架构缺口。

## execution_steps

1. 记录 task class、用户群、threat model、success criteria、operating mode。
2. 盘点七层：Execution、Tooling、Context、Lifecycle、Observability、Verification、Governance。
3. 收集 artifacts：prompts、tool schemas、sandbox images、memory stores、traces、evals、policies、audit logs。
4. 识别跨层耦合和单点故障。
5. 将每层标为 `ready`、`partial` 或 `missing`。
6. 按风险和依赖关系排序修复项。
7. 为每个 harness change 定义 regression tests。

## validation_rules

- 每个发现都映射到至少一个 ETCLOVG layer。
- 每个高严重度问题都说明用户影响和 failure mode。
- 每条建议都有验证路径。
- 输出必须记录 residual risks。

## failure_handling

- 证据不足时创建 discovery task，不猜。
- 架构细节缺失时显式标注 assumptions。
- 多层都可能有责任时，先获取或生成 trace 再归因。

## examples

- `tool calls 没有 trace ID`：Observability + Governance。
- `测试失败后 agent 循环`：Lifecycle + Verification。
- `工具描述占用 40K tokens`：Tooling + Context。
