# Skill: Tool Interface Design

## purpose

设计 agent 可可靠选择、调用、审计的工具与协议，同时控制上下文成本和安全风险。

## when_to_use

- 新增 tools、MCP servers、function calling、browser controls、shell commands、API integrations。
- 出现 tool selection error 或 schema failure。
- tool descriptions 造成 context bloat。
- tool results 难评估或难审计。

## when_not_to_use

- 任务没有外部动作或检索。
- 第三方工具行为完全固定，无法 wrapper、validate 或 route。

## constraints

- 偏好少而表达力强的工具，而不是大量窄工具。
- 每个 tool 必须有清晰 purpose、schema、failure mode、permission class。
- tool outputs 默认不可信，除非来自可信 deterministic component。
- 不暴露当前阶段无关工具。
- tool calls 必须可 trace。

## execution_steps

1. 列出候选工具并按任务阶段分组。
2. 移除重复或语义模糊的工具。
3. 使用 typed parameters 和清晰名称定义 schema。
4. 只有在减少歧义时才加 examples。
5. 执行前 validation，执行后 normalization。
6. 定义当前阶段可见工具的 routing policy。
7. 添加 audit fields：tool name、arguments、caller、permission decision、result reference、latency、cost、error。
8. 用代表性任务和 adversarial prompts 测试 tool selection。

## validation_rules

- 人类从 name/description 能判断何时使用。
- 无效参数在产生 side effect 前失败。
- tool output 有大小边界或 summary 机制。
- permission class 明确。
- trace 支持 replay 或 diagnosis。

## failure_handling

- 选错工具时，先修改 description/routing，不直接怪模型。
- schema 频繁失败时，增加 deterministic validators 和更清晰 error message。
- output 污染 context 时，用 durable reference 替代全文。
- high-risk tool 必须加 policy check 和 human escalation。

## examples

- 只有当参数仍清晰时，才把多个 filesystem tools 合并。
- deployment tool 在 tests/review gate 前不暴露。
- 返回 structured diff summary，而不是完整文件 dump。
