# Innovation Development Track

本文件专门覆盖“创新开发”部分。它定义如何提出、构建、验证和推广新的 harness 机制，避免把未经验证的想法直接变成生产规则。

## Purpose

Harness 创新必须带来可度量收益：可靠性、安全性、成本、延迟、可扩展性、开发者杠杆或 agent 自治能力。一个想法不是因为“新”而被接受，而是因为 trace 和 evaluation 显示它在明确约束下改善了 model-harness pair。

## Innovation Categories

### 新执行基座

例子：microVM pools、OS-level permission sandbox、Kubernetes sandbox CRD、browser/desktop sandbox、WebAssembly runtime、learned surrogate environment。

推广标准：

- reset 可复现。
- isolation 匹配 threat model。
- cost 和 cold-start 有测量。
- failure modes 可追踪。
- security assumptions 已记录。

### 工具与协议创新

例子：dynamic tool routing、MCP server hardening、signed tool descriptors、typed handoff contracts、tool-result provenance。

推广标准：

- tool choice 改善或至少不退化。
- prompt footprint 没有无收益增长。
- schema validation 能捕获 malformed calls。
- permission 与 audit metadata 随调用传递。

### 上下文与记忆创新

例子：uncertainty-aware summaries、provenance-tagged memories、contradiction resolution、context cache optimization、memory retrieval routers。

推广标准：

- memory 提升 downstream task success，而不只是 recall。
- summary 保留 decisions、constraints、unresolved issues。
- token 与 latency overhead 已测量。
- stale 或 hallucinated memory 有检测路径。

### 编排创新

例子：planner-executor-evaluator loop、sprint contract、fan-out/fan-in search、durable human-in-the-loop checkpoint、subagent isolation。

推广标准：

- coordination overhead 已测量。
- role boundary 明确。
- handoff artifacts 完整。
- evaluator independence 保留。
- 系统能正确停止。

### 可观测与评估创新

例子：trace-native failure attribution、production-trace-to-regression、harness ablation dashboard、quality-cost-latency frontier。

推广标准：

- 新 telemetry 回答具体诊断问题。
- sensitive data exposure 已控制。
- regression cases 可复现。
- attribution 经过人工 review 或 deterministic evidence 校验。

### 治理创新

例子：policy DSL、adaptive permission manifest、information-flow control、signed audit log、credential vault mediation。

推广标准：

- policy 可在模型之外执行。
- false positive/false negative 成本已测量。
- audit log 包含 identity、policy version、action、decision、trace ID。
- 高影响动作仍保留 human escalation。

## Innovation Workflow

1. 写假设。
   格式：如果我们在 layer Y 为 task class Z 改变 X，那么 metric M 应改善，因为机制 R。

2. 定义 baseline。
   记录 model、harness version、prompt、tool registry、context policy、sandbox、evaluator、task set。

3. 定义 guardrails。
   明确 cost、latency、safety、completion quality、user intervention rate 的最大可接受退化。

4. 在 flag 后实现。
   新机制必须可回滚、可隔离、trace-labeled。

5. 运行 layered evaluation。
   包括 unit checks、single-step decisions、full rollouts、trajectory review、adversarial/stress cases。

6. 归因结果。
   判断收益来自 prompt、tool、context、lifecycle、observability、verification、governance 还是交互效应。

7. 决定推广级别。
   reject、revise、shadow、limited rollout、promote。

8. 推广后简化。
   删除已过时 scaffold；模型或任务分布变化后重做 ablation。

## Required Experiment Record

每个创新实验必须记录：

- hypothesis。
- target layer。
- task class。
- baseline configuration。
- variant configuration。
- metrics。
- guardrails。
- trace IDs。
- failure cases。
- source confidence。
- decision。

## Hard Constraints

- 不允许只凭 benchmark improvement 推广到生产。
- 不接受隐藏 failure attribution 的机制。
- 没有 trace 证明真实收益时，不增加 multi-agent 复杂度。
- 没有 provenance 和 deletion policy 时，不新增 persistent memory 类型。
- 不允许为了 success rate 弱化 governance，除非有显式风险接受。
- 不允许通过降低 evaluation fidelity 来省成本，除非评估影响被测量。

## Innovation Anti-Patterns

- `Novelty-first design`：因为新而加架构。
- `Metric laundering`：只报告 success rate，隐藏 cost、latency 或 unsafe trajectory。
- `Prompt-only patch`：用 prompt 承担 deterministic policy 的职责。
- `Irreversible experiment`：没有 feature flag 或 rollback 的 harness 变更。
- `No ablation`：没有隔离变量就声称收益。
- `Unowned memory`：增加无人审计的长期记忆。

## Innovation Review Questions

- 它解决了当前 harness 哪个未解决问题？
- 归属哪个 ETCLOVG layer？
- 什么证据会证伪这个想法？
- 哪个 failure mode 会变差？
- 哪类用户、系统或组织风险会改变？
- 模型变强后能否删除该机制？
- 是否制造新的跨层耦合？
- 是否改善 success-cost-latency-risk frontier？

## Example

Hypothesis：

如果 orchestrator 把仓库探索委派给上下文隔离的 subagents，并只接收 1,500-token evidence summaries，那么长程 coding task 的 context drift 应下降，completion quality 应提升，因为探索噪声不会污染主上下文。

Evaluation：

- Baseline：single-agent loop。
- Variant：orchestrator + exploration subagents。
- Metrics：pass rate、token cost、wall time、repeated-file-read count、failed handoffs、reviewer findings。
- Guardrail：除非 pass rate 至少提升 10 percentage points，否则 cost 不得增加超过 35%。
- Promotion：只有当 failure attribution 显示 context-loss failures 减少且 unsafe tool calls 没增加时，进入 limited rollout。
