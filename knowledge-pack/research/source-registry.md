# Source Registry

本文件记录知识包使用的主要证据来源。可信度按保守原则处理：官方文档/官方仓库/顶会论文强于 preprint，preprint 和工程博客强于社区轶事。

## 本地核心来源

| ID | 来源 | 类型 | 可信度 | 用途 |
|---|---|---:|---:|---|
| S0 | `agent harness engineering a survey.pdf` | 本地 survey PDF，under review | Medium | ETCLOVG taxonomy、binding-constraint thesis、harness lifecycle、evaluation lifecycle、跨层综合、open problems |

## 官方工程来源

| ID | 来源 | 类型 | 可信度 | 用途 |
|---|---|---:|---:|---|
| S1 | OpenAI, Harness engineering: leveraging Codex in an agent-first world, https://openai.com/index/harness-engineering/ | 官方工程博客 | High | Codex harness 实践、agent 可读仓库、反馈循环 |
| S2 | OpenAI, Unrolling the Codex agent loop, https://openai.com/index/unrolling-the-codex-agent-loop/ | 官方工程博客 | High | 单 agent loop、工具执行循环、replay 思路 |
| S3 | OpenAI, Open-source Codex orchestration: Symphony, https://openai.com/index/open-source-codex-orchestration-symphony/ | 官方工程博客 | High | issue tracker 作为 agent control plane、长期任务编排、持续 agent loop |
| S4 | OpenAI Agents SDK docs, https://platform.openai.com/docs/guides/agents-sdk/ 与 https://openai.github.io/openai-agents-python/tracing/ | 官方文档 | High | handoffs、tools、tracing、guardrails |
| S5 | OpenAI, Practices for governing agentic AI systems, https://openai.com/index/practices-for-governing-agentic-ai-systems/ | 官方治理资料 | High | agentic AI 治理、监督、部署控制 |
| S6 | Anthropic, Building effective agents, https://www.anthropic.com/engineering/building-effective-agents | 官方工程博客 | High | 优先简单 workflow、agent/workflow 区分 |
| S7 | Anthropic, Effective context engineering for AI agents, https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | 官方工程博客 | High | progressive disclosure、context compaction、高信号上下文 |
| S8 | Anthropic, Effective harnesses for long-running agents, https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents | 官方工程博客 | High | initializer agent、进度 artifact、分阶段长任务 |
| S9 | Anthropic, Claude Code sandboxing, https://www.anthropic.com/engineering/claude-code-sandboxing | 官方工程博客 | High | sandbox liveness、权限提示减少、OS 级限制 |
| S10 | Anthropic, Multi-agent research system, https://www.anthropic.com/engineering/multi-agent-research-system | 官方工程博客 | High | lead/subagent 协调、上下文隔离、多 agent 扩展 |
| S11 | Anthropic, Demystifying evals for AI agents, https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents | 官方工程博客 | High | agent eval、multi-turn eval、grader、trajectory evidence |
| S12 | Anthropic, Harness design for long-running application development, https://www.anthropic.com/engineering/harness-design-long-running-apps | 官方工程博客 | High | planner/generator/evaluator、sprint contract、harness 简化 |
| S13 | Anthropic, Managed Agents, https://www.anthropic.com/engineering/managed-agents | 官方工程博客 | High | brain/hands/session 解耦、durable event log |
| S14 | Anthropic sandbox-runtime, https://github.com/anthropic-experimental/sandbox-runtime | 官方仓库 | High | 文件/网络限制、OS primitives、proxy egress |
| S15 | LangChain, Improving Deep Agents with harness engineering, https://www.langchain.com/blog/improving-deep-agents-with-harness-engineering | 官方工程博客 | High | harness-only 改进、prompt/context/self-verification |
| S16 | LangChain, Evaluating deep agents, https://www.langchain.com/blog/evaluating-deep-agents-our-learnings | 官方工程博客 | High | single-step、full-turn、multi-turn eval |
| S17 | LangGraph docs, https://docs.langchain.com/oss/python/langgraph | 官方文档 | High | durable execution、persistence、human-in-the-loop |
| S18 | Model Context Protocol specification, https://modelcontextprotocol.io/specification/2025-06-18 | 官方规范 | High | tool/resource/prompt 协议边界 |
| S19 | A2A protocol, https://github.com/a2aproject/A2A | 官方仓库 | High | agent-to-agent cards、streaming、长任务通信 |
| S20 | OpenTelemetry GenAI semantic conventions, https://opentelemetry.io/docs/specs/semconv/gen-ai/gen-ai-spans/ | 官方规范 | High | trace attributes、token usage、GenAI spans |
| S21 | OWASP Top 10 for LLM Applications, https://owasp.org/www-project-top-10-for-large-language-model-applications/ | 安全标准项目 | High | prompt injection、excessive agency、supply chain、tool security |
| S22 | Docker Sandboxes, https://www.docker.com/blog/docker-sandboxes-a-new-approach-for-coding-agent-safety/ | 官方工程博客 | Medium | coding-agent 隔离、workspace 边界 |
| S23 | Kubernetes agent-sandbox, https://github.com/kubernetes-sigs/agent-sandbox | 官方 SIG 仓库 | High | declarative sandbox CRD、stateful singleton workloads |

## 论文与 Benchmark

| ID | 来源 | 类型 | 可信度 | 用途 |
|---|---|---:|---:|---|
| P1 | ReAct, https://arxiv.org/abs/2210.03629 | 研究论文 | High | observe-think-act loop |
| P2 | SWE-bench, https://proceedings.iclr.cc/paper_files/paper/2024/hash/edac78c3e300629acfe6cbe9ca88fb84-Abstract-Conference.html | ICLR 2024 | High | GitHub issue 级可执行评估 |
| P3 | OpenHands, https://proceedings.iclr.cc/paper_files/paper/2025/hash/a4b6ad6b48850c0c331d1259fc66a69c-Abstract-Conference.html | ICLR 2025 | High | software agent platform |
| P4 | Lost in the Middle, https://aclanthology.org/2024.tacl-1.9/ | TACL 2024 | High | long-context 位置信息退化 |
| P5 | MemGPT, https://arxiv.org/abs/2310.08560 | preprint | Medium | OS-style memory tiers |
| P6 | Generative Agents, https://dl.acm.org/doi/10.1145/3586183.3606763 | UIST 2023 | High | observation/reflection/retrieval memory loop |
| P7 | Mem0, https://arxiv.org/abs/2504.19413 | preprint | Medium | production long-term memory |
| P8 | AgentDojo, https://proceedings.neurips.cc/paper_files/paper/2024/hash/97091a5177d8dc64b1da8bf3e1f6fb54-Abstract-Datasets_and_Benchmarks_Track.html | NeurIPS 2024 | High | tool-using agent prompt injection eval |
| P9 | CaMeL, https://arxiv.org/abs/2503.18813 | preprint | Medium | capability-based information flow control |
| P10 | Toolformer, https://proceedings.neurips.cc/paper_files/paper/2023/hash/d842425e4bf79ba039352da0f658a906-Abstract-Conference.html | NeurIPS 2023 | High | tool-use learning |
| P11 | ToolLLM, https://openreview.net/forum?id=dHng2O0Jjr | ICLR 2024 | High | tool-use training and benchmark |

## 社区补充信号

| ID | 来源 | 类型 | 可信度 | 用途 |
|---|---|---:|---:|---|
| C1 | Reddit/Claude/Codex 讨论中的 compaction loop、tool descriptor bloat、sandboxing 经验 | 社区轶事 | Low | 只用于发现潜在失败模式，不单独支撑硬规则 |
| C2 | GitHub issues/discussions in agent repos | 社区实现反馈 | Low to Medium | 有可复现代码或维护者确认时，可作为 operational edge case |

## 证据使用规则

- `High` 可信工程约束至少应由一个官方来源或同行评审论文支持。
- `Medium` 建议可以来自高质量 preprint 或工程博客，但要保留“不完全复现”的限制。
- `Low` 社区观察只能生成测试假设，不能直接变成硬规则。
- 来源冲突时，部署事实优先看离系统最近的官方资料；benchmark 结论优先看方法学更强的论文或复现。
