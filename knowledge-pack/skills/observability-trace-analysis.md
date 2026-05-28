# Skill: Observability And Trace Analysis

## purpose

对 agent run 做 instrumentation 和 trace analysis，让失败可诊断、成本可测量、回归可复现。

## when_to_use

- debug agent failure。
- 构建生产监控。
- 从真实 trace 生成 regression cases。
- 比较 harness variants。

## when_not_to_use

- 没有 agent action 或 tool call。
- 无法安全记录敏感数据且没有 redaction 路径。

## constraints

- trace ID 必须串联 model calls、tool calls、sandbox events、permission decisions、verifier results、user-visible outputs。
- sensitive data 必须 redacted 或 access-controlled。
- telemetry 要足够诊断，但不能泄露 secrets。
- cost 和 latency 是一等信号。

## execution_steps

1. 定义 trace schema 和 required fields。
2. instrument LLM calls、tool calls、retrieval、context assembly、policy checks、sandbox events、retries、verifiers。
3. 捕获 cost、latency、token counts、model name、tool name、error type、policy version。
4. 将事件链接到 durable artifacts。
5. 分析 loops、redundant calls、permission violations、failed recovery、drift、cost spikes。
6. 将重要失败转成 regression tests。
7. 检查 telemetry volume 与 privacy controls。

## validation_rules

- failed run 有足够 trace 做 layer-level attribution。
- trace 包含 model、prompt、tool registry、policy、sandbox、evaluator version。
- cost 和 latency 可按 task/tool 聚合。
- production failure trace 可 replay 或近似复现。

## failure_handling

- trace 缺失：先加 instrumentation 再做 root-cause claim。
- telemetry 泄露敏感数据：停止 export 并增加 redaction。
- 数据量过高：低风险 span 采样，高风险失败保留 full spans。
- attribution 不清：在 layer boundary 增加 targeted spans。

## examples

- trace 显示找错文件：Context/Tooling。
- trace 显示 patch 对但测试环境坏：Execution/Evaluation。
- trace 显示重复审批：Governance/Lifecycle。
