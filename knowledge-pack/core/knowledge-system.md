# Harness Engineering Knowledge System

## 1. Executive Summary

Harness engineering 是围绕 LLM agent 构建可靠执行外壳的系统工程。它不只处理 prompt，而是同时处理执行环境、工具接口、上下文、生命周期、可观测、验证评估、治理安全。

核心原则：评估和优化对象必须是 `model-harness pair`，不是模型单体。强模型在弱 harness 下仍会失败；固定模型在更好的 harness 下也可能显著提升。

主要证据：本地 survey S0；OpenAI Codex harness 资料 S1-S4；Anthropic agent/harness/context/eval 资料 S6-S13；LangChain harness/eval 资料 S15-S17；MCP、A2A、OpenTelemetry、OWASP 规范 S18-S21。

## 2. Core Concepts

### Agent Harness

`Fact, S0, Medium`：Harness 是把模型调用转化为有边界、有状态、可调用工具、可验证执行的工程 wrapper。

运行上，harness 负责：

- 接收任务意图。
- 构造模型上下文。
- 暴露工具和执行环境。
- 运行生命周期循环。
- 记录 trace。
- 验证结果。
- 执行权限与治理策略。
- 从失败中恢复。

### ETCLOVG

`Fact, S0, Medium`：ETCLOVG 把 harness 拆为七层：

- `E`：Execution environment and sandbox。
- `T`：Tool interface and protocol。
- `C`：Context and memory。
- `L`：Lifecycle and orchestration。
- `O`：Observability and operations。
- `V`：Verification and evaluation。
- `G`：Governance and security。

### Closed-Loop Controller

`Inference, S0+S11+S20, High`：生产级 harness 更像控制器：观测状态、选择行动、检查输出、归因失败、修正后续执行。

### Durable Task State

`Practice, S8+S13+S17, High`：长期任务必须使用 durable artifacts，例如计划、进度文件、event log、checkpoint、patch、test、audit record。对话历史不能作为唯一事实来源。

## 3. Engineering Principles

1. 以系统为单位优化 harness。
   `Practice, High`：不要孤立调 prompt、tool、memory、sandbox、eval，必须做系统级回归检查。

2. 从最小可靠 loop 开始。
   `Practice, S6, High`：只有当任务需要角色分离、并行、durable state 或显式控制流时，再引入复杂 agent 编排。

3. 状态必须外部化、可检查。
   `Practice, S8+S13, High`：计划、进度、artifact、credential、policy version、trace ID 应能被人和 agent 读取。

4. 采用有边界的自治。
   `Practice, S9+S21, High`：让 agent 在清晰的执行、权限、预算、网络边界内自由行动。

5. Trace 是一等证据。
   `Practice, S11+S20, High`：关键 model call、tool call、retrieval、context update、permission decision、retry、cost event、verifier result 都应可追踪。

6. 能力和权限分离。
   `Practice, S18+S21+P9, High`：工具可用不等于 agent 在任何上下文都被授权使用。

7. 模型升级后重新评估 harness 假设。
   `Practice, S12+S13+S15, High`：每个 harness 组件都隐含“模型做不好什么”的假设，这些假设会过期。

8. 失败必须可归因。
   `Practice, S11+S16, High`：失败报告至少应指向 task spec、model reasoning、tool schema、sandbox、context、lifecycle、evaluator 或 governance 中的可能层。

## 4. System Design Patterns

### Bounded Sandbox Pattern

为 agent action 提供可 reset、可审计、有文件/网络/资源边界的环境。按 threat model 选择隔离强度：

- 可信本地 coding：OS-level path allowlist 与 network proxy 可能足够。
- 常规可复现开发：container。
- 不可信代码或多租户：microVM 或等价强隔离。
- browser/desktop 任务：专用 browser/desktop sandbox。
- agent fleet：Kubernetes CRD 或 sandbox abstraction。

证据：S9、S14、S22、S23。

### Progressive Disclosure Pattern

上下文保持小而高信号。总是需要的 policy 和任务状态预加载；条件性信息通过检索或工具按需加载。

证据：S7、P4。

### Durable Handoff Pattern

停止或委派前必须写清：

- 当前目标。
- 已完成工作。
- 剩余任务。
- 变更的文件或 artifact。
- 已运行命令/测试。
- 已知失败。
- 下一步建议。

证据：S8、S13、S17。

### Trace-Native Evaluation Pattern

完整记录执行 trace，然后评估：

- 结果是否正确。
- 轨迹是否合理。
- 是否遵守 policy。
- 成本与延迟。
- evaluator 是否可靠。
- 失败可归因到哪一层。

证据：S11、S16、S20。

### Planner-Executor-Evaluator Pattern

长程、模糊或高风险任务中，拆分 planning、implementation、verification。Evaluator 必须足够独立，不能让实现者单独判定完成。

证据：S10、S12。

### Tool Router Pattern

不要每次暴露所有工具。按任务阶段、权限、上下文动态暴露小而相关的工具子集。

证据：S7、S18、P10、P11。

### Governance Hook Pattern

在 LLM 输入前、工具调用前、工具返回后、最终响应/高影响动作前插入治理检查。结构性约束优先用 deterministic checks。

证据：S21、P8、P9。

## 5. Anti-Patterns

- `All tools always visible`：增加 token 成本、选择错误和攻击面。
- `Conversation as database`：在 compaction、crash、handoff、context drift 中丢状态。
- `Final-score-only eval`：隐藏坏轨迹、不安全成功、flaky grader、成本爆炸。
- `Human approval spam`：让用户形成机械批准，破坏 liveness。
- `Sandbox as only security`：限制 blast radius，但不解决语义授权和 prompt injection。
- `Multi-agent by default`：未证明收益就引入协调成本。
- `Prompt patch without regression`：修一个可见失败，制造不可见漂移。
- `Unversioned judge prompt`：让历史 eval 不可比较。
- `Memory without provenance`：把过期或幻觉内容当未来上下文。
- `No budget boundary`：允许无限 loop、tool call 和 subagent fan-out。

## 6. Agent Constraints

使用本知识包的 agent 必须：

- 在改动前识别当前涉及的 harness layer。
- 用 durable artifacts 记录计划、进度、评估和 handoff。
- 不输出无法连接到来源、trace、测试或显式假设的重要结论。
- 把破坏性动作视为 governed actions。
- 有 schema 时必须验证工具输入输出。
- 保持上下文小而高信号，按需检索材料。
- 声称完成前必须验证。
- 验证不完整时记录残余风险。
- policy、credential、安全或业务影响不明确时升级给人。

## 7. Recommended Workflow

1. Ground the task。
   记录目标、约束、成功标准、风险等级、允许工具、执行环境、评估计划。

2. Prepare the harness。
   验证 sandbox、依赖、credential、permission、context state、tool registry、budget、trace 配置。

3. Plan with artifacts。
   写短计划：里程碑、验证门、回滚策略、handoff state。

4. Execute incrementally。
   小步执行。每步后更新进度，按风险运行检查。

5. Capture traces and evidence。
   记录 model call、tool call、decision、error、retry、state change、verifier output。

6. Evaluate at multiple levels。
   评估 outcome、trajectory、evaluator reliability、policy compliance、cost、latency。

7. Attribute failures。
   将失败映射到 ETCLOVG 层，更新测试或约束。

8. Close with handoff。
   写清变更、验证、未确定事项和下一步。

## 8. Failure Recovery Strategy

| Layer | 常见失败 | 恢复策略 |
|---|---|---|
| E | sandbox 损坏、依赖漂移、timeout | 从 baseline reset，重建 image，在 clean env 重试，记录配置 |
| T | 选错工具、schema error、stale handle | 验证 schema，刷新 session，减少工具集，改进描述 |
| C | context 丢失、memory 过期、retrieval 错误 | 从 durable artifacts 重建，检索来源，带 provenance 重写 summary |
| L | loop、过早完成、委派错误 | 增加 stop conditions、checkpoints、角色边界、verifier gate |
| O | trace 缺失、归因困难 | 添加 span/event、trace ID、cost fields、permission fields |
| V | flaky tests、bad judge、rubric 模糊 | version graders，多次运行，添加 deterministic checks |
| G | 权限过宽、prompt injection、secret exposure | 撤销权限、隔离数据、轮换 credential、增加 hooks/audit |

Retry policy：

- transient infrastructure failure 可以有限重试。
- semantic failure 不应盲目重试。
- 重试前先判断 failure 属于 environment、tool、context、model 还是 evaluator。
- 诊断时一次只改变一个变量。

## 9. Evaluation Methodology

使用五阶段 task-to-feedback lifecycle：

1. Task and benchmark grounding：定义环境状态、允许工具、约束、成功谓词、终止条件。
2. Pre-execution readiness：验证 sandbox reset、依赖、tool registry、context init、permission、budget、grader version。
3. Controlled execution and trace capture：固定 model/harness 配置运行，捕获 spans、messages、tools、state changes、errors、retries、cost、latency。
4. Multi-level judgement：评估 outcome、trajectory、evaluator reliability、policy compliance。
5. Regression feedback：把失败转为测试、monitor、prompt change、tool change、context rule、sandbox fix、governance update。

评估输出必须包含：

- model 与 harness version。
- prompt 与 policy version。
- tool registry version。
- sandbox/runtime version。
- context/memory policy。
- judge/grader version。
- trace ID。
- cost 与 latency。
- failure attribution。
- residual uncertainty。

证据：S11、S16、P2、P3。

## 10. Scalability Considerations

- cold start 成本高时，用 sandbox warm pool 或可复用 stateful runtime。
- 不可信代码和多租户优先强隔离。
- 长任务使用 checkpoint。
- 稳定 prompt prefix 和 deterministic serialization 以提高 context cache 命中。
- 用 tool routing 降低 token footprint。
- 可异步运行高成本 evaluation 和 trajectory analysis。
- 对 token、wall time、tool call、retry、subagent 设置预算。
- 评估 success-cost-latency frontier，而不是只看 success。

证据：S13、S17、S20、S22、S23。

## 11. Security Constraints

安全必须覆盖 model、tool、data、runtime、identity、supply chain。

硬约束：

- tools、files、network、credentials、external APIs 最小权限。
- destructive、irreversible、external、expensive actions 必须有明确 permission policy。
- secrets 不得进入 model context。
- untrusted data 必须标记，并阻止其控制 privileged actions。
- tool descriptors 和 MCP servers 必须视为 supply-chain inputs。
- audit records 必须包含 policy decision 与 policy version。
- human approval 要有足够上下文，且不能过度使用。
- 代码执行或文件修改必须在 sandbox 中进行。

证据：S14、S18、S21、P8、P9。

## 12. Prompt Design Rules

- system prompt 要短到可维护。
- 用明确 sections：role、objective、constraints、tool policy、output format、escalation。
- 只针对已观察失败增加 instruction。
- 稳定 instruction 放在动态 context 前。
- 不要把 policy 藏在模糊自然语言中；能用 hard constraints 和 validators 就不要只靠 prompt。
- prompt 中不放 secrets 或 credentials。
- 不让 prompt 承担 harness 应该执行的 enforcement。

证据：S7、S11、S21。

## 13. Tool Usage Policy

- tool 必须有清晰 name、description、parameter schema、error mode、example。
- 偏好少而表达力强的工具。
- 按阶段和权限路由工具。
- 执行前验证 tool arguments。
- 非确定性或外部来源的 tool outputs 默认不可信。
- 大型 tool outputs 使用后应压缩为 reference。
- 记录 tool calls、arguments、output reference、latency、cost、errors。

证据：S18、S20、P10、P11。

## 14. Memory Management Rules

- active context 不是 memory。
- session notes、progress files、checkpoints 是 mid-term state。
- long-term memory 需要 provenance、timestamp、confidence、contradiction handling、deletion policy。
- retrieval 应按查询和预算执行。
- summary 必须保留 decisions、constraints、unresolved issues、evidence links。
- 未验证的幻觉输出不得持久化为 memory。
- 定期审计 stale assumptions。

证据：S7、P4、P5、P6、P7。

## 15. Multi-Agent Collaboration Rules

- 只有当 decomposition、parallel exploration、context isolation 或 independent verification 有明确价值时才用 subagents。
- 不要把 orchestrator 下一步立即依赖的 blocking task 委派出去后空等。
- 给每个 agent 明确 ownership、inputs、expected output、constraints、validation criteria。
- 计划和进度必须有 single source of truth。
- subagents 必须返回 distilled evidence、changed files、risks、verification results。
- 没有 merge protocol 时避免重叠 write scope。
- multi-agent 系统要评估 coordination failures，而不仅是任务 outcome。

证据：S10、S12、S17、S19。
