# External Research Findings

本文件汇总外部高质量资料的工程结论。来源详见 `source-registry.md`。

## 1. 社区与官方工程实践

- `Fact, S1-S3, High`：OpenAI 将 Codex 相关能力组织为可复用 harness：任务环境、工具调用、agent loop、状态/仓库上下文、评估反馈共同决定 agent 表现。
- `Fact, S6, High`：Anthropic 建议先使用简单、可组合、可检查的 workflows；只有在需要动态决策和长期自治时才引入更复杂 agents。
- `Fact, S8, High`：长程 agent 需要 initializer、进度 artifacts、分阶段执行和干净 handoff state，以避免 one-shot、过早完成和断点丢失。
- `Fact, S15, High`：LangChain 的 Deep Agents 改进案例强调 prompt restructuring、middleware context injection、self-verification hooks 等 harness 层改动会影响 benchmark 表现。
- `Practice, High`：社区落地方式的共识是把 agent 当作受控执行系统，而不是只依靠模型自律。

## 2. 实际落地方式

- `Fact, S13, High`：Managed agents 架构倾向把 brain、hands、session 分离。Brain 是 harness + LLM，hands 是 sandbox/tools，session 是 durable event log。
- `Fact, S17, High`：LangGraph 等平台强调 durable execution、persistence、human-in-the-loop，说明 agent workflow 已从函数调用转向可恢复流程。
- `Fact, S18, High`：MCP 把 tools、resources、prompts 作为协议对象暴露，降低 tool integration 成本。
- `Fact, S19, High`：A2A 关注 agent-to-agent 协作边界，补充 MCP 的 tool/context access 边界。
- `Practice, High`：生产落地应优先让 state、permission、trace、evaluation metadata 显式化，而不是把它们隐含在 chat transcript 中。

## 3. 常见失败案例

- `Fact, S8, High`：长期 coding agents 常见失败包括试图一次性完成全部任务、过早宣布完成、跨 session 环境不干净、未测试就标记完成。
- `Fact, S21, High`：OWASP LLM 风险覆盖 prompt injection、excessive agency、supply-chain、sensitive information disclosure 等 agent 相关风险。
- `Fact, P4, High`：long-context 中相关信息位置会影响模型表现，说明“信息在上下文中”不等于“模型可靠使用它”。
- `Fact, P8, High`：工具型 agent 面对 indirect prompt injection 有专门 benchmark，说明检索内容和 tool output 不能默认可信。
- `Practice, High`：失败分析必须看 trace，而不是只看最终回答或最终测试结果。

## 4. Scaling Strategy

- `Fact, S13, High`：可扩展 agent 基础设施需要可替换的 session、tools/sandboxes、event logs；组件 failure 应可被 reprovision 和 resume。
- `Fact, S20, High`：OpenTelemetry GenAI conventions 支持用标准 telemetry 表示 model/tool 调用、token、latency 等，为 agent fleet 观测提供共同格式。
- `Fact, S23, High`：Kubernetes agent-sandbox 代表把 sandbox 抽象为 declarative workload 的方向。
- `Practice, High`：扩展时需要同时控制 sandbox cold start、context/token cost、tool fan-out、trace volume、evaluation cost。
- `Inference, Medium`：大规模评估和训练会推动从单容器任务环境走向 sandbox pools、snapshotting、remote execution、declarative runtime。

## 5. Agent Orchestration Patterns

- `Fact, S6, High`：workflow 与 agent 应区分；前者路径更固定，后者动态决策更多。
- `Fact, S10, High`：Anthropic multi-agent research system 使用 lead agent 协调 subagents，利用上下文隔离和并行探索提升复杂研究任务能力。
- `Fact, S12, High`：planner/generator/evaluator 分离可约束长程开发任务，但 harness complexity 应随模型能力变化而简化。
- `Practice, High`：multi-agent 只应在分解、并行、隔离或独立验证带来明确收益时使用。

## 6. Memory Management

- `Fact, S7, High`：上下文工程强调高信号 token、progressive disclosure、compaction 和 just-in-time retrieval。
- `Fact, P4, High`：long context 存在 positional degradation。
- `Fact, P5, Medium`：MemGPT 将 context window 类比为 RAM，将外部存储类比为 disk。
- `Fact, P6, High`：Generative Agents 使用 observation、reflection、retrieval 组织 agent memory。
- `Fact, P7, Medium`：Mem0 等生产记忆系统试图降低 token 使用并提升 long-term personalization，但其数值结论仍应按 preprint 处理。
- `Practice, High`：memory entry 必须有 provenance、timestamp、confidence、staleness handling。

## 7. Tool Calling Strategy

- `Fact, S18, High`：MCP 为 tool/resource/prompt 暴露提供标准化协议边界。
- `Fact, P10, High`：Toolformer 说明 tool-use 能通过训练信号学习。
- `Fact, P11, High`：ToolLLM/ToolBench 强调工具学习需要大规模 API 语料和执行反馈。
- `Practice, High`：运行时 tool quality 由 schema、description、selection policy、permission、trace、model 能力共同决定。
- `Practice, Medium`：大工具库应使用 routing/retrieval，而不是把所有 tool descriptions 放入上下文。

## 8. Sandboxing

- `Fact, S9, High`：sandboxing 在 agent 场景中不仅是 security，也是 liveness 机制：在边界内减少人类审批。
- `Fact, S14, High`：Anthropic sandbox-runtime 用 OS-level restrictions 管控 filesystem/network。
- `Fact, S22, Medium`：Docker 将 coding-agent safety 与隔离执行环境绑定。
- `Practice, High`：sandbox 必须与 permission model、audit、evaluation reset 共同设计。
- `Inference, Medium`：不同 threat model 对应不同 isolation 选择，不存在所有场景最优的单一 sandbox。

## 9. Evaluation Harness

- `Fact, S11, High`：agent eval 应覆盖多步执行、tools、环境和 grader；不能只看最终文本。
- `Fact, S16, High`：LangChain 将 deep agent evaluation 拆为 single-step、full-turn、multi-turn 等不同粒度。
- `Fact, P2, High`：SWE-bench 以真实 GitHub issue 和可执行 tests 作为 software agent 评估基础。
- `Fact, P3, High`：OpenHands 展示了 software agent platform 对 terminal、browser、code execution 和 benchmark 的集成。
- `Practice, High`：evaluation 必须记录 harness configuration，否则 score 不可解释。

## 10. Prompt Governance

- `Fact, S5, High`：OpenAI 的 agentic AI governance 强调限制 agent 行动能力、监督和可控部署。
- `Fact, S21, High`：OWASP 将 excessive agency 和 prompt injection 等纳入 LLM application 风险。
- `Fact, P9, Medium`：CaMeL 等研究将 untrusted data 与 control flow 分离，以减少 prompt injection 影响。
- `Practice, High`：prompt 只适合表达 intent 和 guidance；真正的 enforcement 应放在 policy、tool validation、sandbox、audit 中。

## 11. Multi-Agent Coordination

- `Fact, S10, High`：multi-agent 能通过并行和上下文隔离处理复杂研究任务，但会增加 coordination overhead。
- `Fact, S19, High`：A2A 说明 agent-to-agent 交互需要标准化身份、能力描述和任务通信边界。
- `Practice, High`：orchestrator 必须保留 single source of truth，并要求 subagents 返回 evidence、risks、verification status。
- `Inference, Medium`：未来 handoff contract 应包含 intent、constraints、permissions、artifacts、provenance、budget、trace history、unresolved decisions。

## 阶段 2 Review

外部资料充分支持以下高置信结论：

- Harness 是生产 agent 的控制系统，而非 prompt 附属物。
- Context、tool、sandbox、evaluation、governance 的改动都能显著改变 agent 行为。
- 长程任务必须依赖 durable artifacts 和 trace，而不是对话历史。
- Evaluation 必须评估 model-harness pair。
- 创新开发必须通过 hypothesis、baseline、trace、regression 和 guardrails 管控。

仍需谨慎的部分：

- 部分 2026 benchmark 数值和新论文仍需复现。
- 社区实践中的个别经验只能作为测试假设。
- 不同 sandbox/runtime 的真实性能对比依赖 workload，需要本地评估。
