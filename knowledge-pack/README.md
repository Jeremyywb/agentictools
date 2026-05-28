# Harness Engineering Knowledge Pack

这是一套可长期复用的 Harness Engineering 知识包。它基于本地论文 `agent harness engineering a survey.pdf`，并结合 OpenAI、Anthropic、LangChain、MCP、A2A、OpenTelemetry、OWASP 以及高质量论文/仓库资料，提炼为其他 agent 可直接加载的知识资产。

## 使用顺序

1. 先读 `research/source-registry.md`，理解证据来源和可信度。
2. 再读 `research/paper-analysis.md`，区分论文明确观点、隐含设计思想和工程推断。
3. 把 `core/knowledge-system.md` 作为长期工程记忆。
4. 涉及新机制、新实验、新架构时，加载 `core/innovation-development.md`。
5. 按任务需要加载 `skills/`、`rules/`、`templates/`、`system-prompts/`、`checklists/` 中的局部文件，不要一次性塞满上下文。

## 目录说明

- `research/`：证据来源、可信度、论文解析。
- `core/`：核心方法论、工程原则、创新开发流程。
- `skills/`：可复用 agent 技能，每个技能包含目的、适用/不适用场景、约束、步骤、验证和失败处理。
- `rules/`：硬约束规则，包括 coding、orchestration、context、planning、retry、verification。
- `templates/`：计划、评估、调试、任务拆解、创新实验模板。
- `system-prompts/`：orchestrator、researcher、evaluator、implementer、reviewer、innovator 角色提示词。
- `checklists/`：任务就绪、执行验证、幻觉检测、完成标准、创新准入检查清单。

## 核心立场

Harness engineering 不是普通 prompt 优化，而是围绕 LLM agent 构建可靠执行外壳的系统工程：执行环境、工具、上下文、生命周期、可观测、验证评估、治理安全必须一起设计。

长期任务的可靠性应被视为 `model + harness` 的组合属性，而不是模型单独属性。

## 证据标签

- `Fact`：来源直接支持的事实。
- `Inference`：由多个事实推出的设计理解。
- `Practice`：可执行工程建议。
- `Community`：社区观察，只作为弱信号。

## 可信度标签

- `High`：官方文档、官方仓库、顶会/同行评审论文，或多个高质量来源一致支持。
- `Medium`：高质量工程博客、preprint、基准论文、维护良好的项目，但仍需更多复现。
- `Low`：单个轶事、Reddit/HN、未审计 benchmark、方法不透明来源。

## 创新开发

“创新开发”已经作为一等模块处理。新的 harness 想法必须写成可证伪假设，在可回滚开关后实现，通过 trace、回归评估和风险约束验证，只有在质量、成本、延迟、安全或可维护性上有可重复收益时才可推广。
