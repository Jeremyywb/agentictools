# Paper Analysis: Agent Harness Engineering: A Survey

来源：本地 PDF `agent harness engineering a survey.pdf`。

## 总体判断

这篇 survey 的价值不在于给出某个单一 agent 框架的使用说明，而在于把 agent harness 明确为独立工程层，并用 ETCLOVG 七层结构描述长期任务中真正决定可靠性的系统外壳。

ETCLOVG 七层：

- Execution environment and sandbox：执行环境与沙箱。
- Tool interface and protocol：工具接口与协议。
- Context and memory management：上下文与记忆管理。
- Lifecycle and orchestration：生命周期与编排。
- Observability and operations：可观测与运维。
- Verification and evaluation：验证与评估。
- Governance and security：治理与安全。

## 论文明确提出的内容

### Harness Over Model

- `Fact, S0, Medium`：论文提出 binding-constraint thesis，即长程 agent 任务的结果差异可能很大程度由 execution harness 决定，而不只是模型能力决定。
- `Fact, S0, Medium`：论文把 harness 定义为管理 context construction、tool interaction、orchestration、feedback、execution constraints 的基础设施层。
- `Fact, S0, Medium`：论文引用了工具格式、prompt/context/self-verification、自动 harness 优化等 harness-only 改动带来的 benchmark 提升，但这些数值应保留为来源结论，不泛化为普遍规律。

### 三个工程阶段

- `Fact, S0, Medium`：Prompt engineering 主要优化单次模型调用的文本输入。
- `Fact, S0, Medium`：Context engineering 优化每一步 inference 时模型可见的信息状态。
- `Fact, S0, Medium`：Harness engineering 在 prompt 和 context 之上加入 state、tools、feedback、governance、execution controls、verification loops。

### ETCLOVG Taxonomy

- `Fact, S0, Medium`：E/T/C/L 是结构核心。
- `Fact, S0, Medium`：O/V/G 是控制平面。
- `Fact, S0, Medium`：论文明确把 Observability 和 Governance 提升为一等 layer，而不是 lifecycle hooks 的副作用。

### Execution Model

- `Fact, S0, Medium`：Sandbox 在 agent 场景中同时承担 security、reproducibility、liveness 三种职责。
- `Fact, S0, Medium`：沙箱选择取决于 workload fidelity、threat model、operational mode、reset cost。
- `Fact, S0, Medium`：基础设施级隔离和语义/能力级隔离互补，不能互相替代。

### Tool Interface Model

- `Fact, S0, Medium`：协议解决调用如何跨系统边界发生；tool selection 解决当前应该暴露哪些能力。
- `Fact, S0, Medium`：过大的 tool menu 会增加 prompt footprint 和 planner branching。
- `Fact, S0, Medium`：长程任务中 tool session state 必须被 lifecycle 管理，尤其是在 retry、parallel call、delegation 下。

### Context And Memory Strategy

- `Fact, S0, Medium`：更大的 context window 不等于解决记忆问题。
- `Fact, S0, Medium`：active context、session persistence、long-term memory 是不同时间尺度。
- `Fact, S0, Medium`：context drift 需要 observability、verification、governance 共同处理，不能只靠 summary。

### Lifecycle And Orchestration

- `Fact, S0, Medium`：Lifecycle state 是 operational state，包括 pending subtasks、checkpoints、retries、artifacts、session status、handoff metadata。
- `Fact, S0, Medium`：single-agent loop、multi-agent orchestration、full issue-to-PR workflow 是不同编排层级。
- `Fact, S0, Medium`：实际系统常采用 hybrid 设计：replayable history 加 persistent artifacts。

### Evaluation Methodology

- `Fact, S0, Medium`：harness evaluation 应把分数视为 model-harness pair 的属性。
- `Fact, S0, Medium`：论文提出五阶段 task-to-feedback lifecycle：grounding、readiness validation、controlled execution and trace capture、judgement and attribution、regression feedback。
- `Fact, S0, Medium`：最终分数不足以解释系统质量；必须评估 outcome、trajectory、evaluator reliability、failure attribution。

### Governance And Security

- `Fact, S0, Medium`：Governance 包括 permission models、lifecycle hooks、component hardening、declarative constitutions、audit infrastructure。
- `Fact, S0, Medium`：只靠人类审批会遇到 habituation 和 comprehension 问题。
- `Fact, S0, Medium`：长程 agent 治理必须处理演化中的 permission、state、credentials、auditability。

## 论文隐含设计思想

- `Inference, S0+S7+S11, High`：Harness 是 closed-loop controller，不是被动 wrapper。它观测状态、约束行动、评估结果并更新后续行为。
- `Inference, S0+S20, High`：Trace 是 observability、evaluation、governance、debugging 的共同底座。没有结构化 trace，failure attribution 会退化为猜测。
- `Inference, S0+S8+S13, High`：长期任务中，durable artifacts 比对话历史更可靠。计划、进度文件、event log、patch、test、handoff record 应是一等状态。
- `Inference, S0+S18+S19, High`：互操作标准只有在 provenance、permission、trace metadata 也能跨边界传递时，才真正降低系统风险。
- `Inference, S0+S12+S15, High`：harness 组件应随模型能力变化重新评估；旧 scaffold 可能从必要控制变成成本和故障来源。

## 工程实践推断

- `Practice, High`：prompt、tool、sandbox image、memory policy、orchestration、governance、judge 的任何改动都应视为 harness change，并触发 regression evaluation。
- `Practice, High`：active context 应小而高信号；长期任务状态应保存在上下文窗口之外。
- `Practice, High`：高影响动作优先用 deterministic checks，其次 LLM review，仍有风险或歧义时 human approval。
- `Practice, High`：代码执行、文件修改、外部调用必须运行在有边界、可 reset、可 audit 的执行环境中。
- `Practice, Medium`：工具应少而清晰；大工具库应通过 retrieval/routing 动态暴露。
- `Practice, Medium`：multi-agent 只在并行探索、角色分离、独立验证或上下文隔离带来明确收益时使用。

## 论文不足

- 论文偏 taxonomy 和 ecosystem mapping，尚未给出规范化设计评分表。
- 部分 2026 来源较新或仍是 preprint，数值结论需要谨慎复现。
- 语料偏英语、GitHub 可见、coding-agent 生态。
- Governance 的 policy、hook、audit、handoff 标准仍碎片化。
- 论文没有完整定义“创新开发”流程；本知识包在 `core/innovation-development.md` 补足。

## 阶段 1 Review

阶段 1 已完成。论文足以支撑知识包主框架。最可复用的资产是 ETCLOVG、model-harness pair 评估原则、五阶段 evaluation lifecycle、跨层 tradeoff，以及长期 harness 作为 control system 的理解。
