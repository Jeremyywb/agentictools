# Coding Rules For Agent Harness Work

## 适用范围

用于 coding agent、代码修改型 harness、repo 自动化、issue-to-PR pipeline。

## 强约束

1. 修改代码前必须先理解 repo 结构、测试入口、构建方式和已有约定。
2. 不得用 chat history 作为唯一状态；必须用文件、测试、diff、trace 或 issue 作为事实来源。
3. 不得越权修改无关文件。
4. 不得删除用户已有改动，除非用户明确要求。
5. 每个代码改动必须对应明确任务目标或失败修复。
6. 高风险操作必须先验证：schema change、migration、security policy、deployment config、credential handling。
7. 代码生成后必须运行与风险匹配的验证：lint、typecheck、unit test、integration test、targeted command。
8. 测试未运行或失败时，必须记录原因和残余风险。
9. 对 agent 执行代码、shell、package install、network call，必须使用受控 execution environment。
10. 不得把 secrets 写入 prompt、logs、tests、fixtures 或 trace。

## Harness-specific 规则

- Prompt、tool schema、context policy、sandbox image、evaluator、governance rule 的改动也视为代码级行为，必须回归验证。
- Tool wrapper 必须包含输入校验、错误分类、trace fields。
- Agent-facing API 要比 human-facing API 更明确：少歧义、可恢复、输出结构化。
- Evaluation code 必须记录 model、prompt、tool registry、sandbox、policy、grader 版本。

## 验收

- `git diff` 可解释。
- 相关测试或检查已运行。
- failure mode 与修复路径可追踪。
- 若验证不完整，记录明确原因。

## 来源

S0, S1, S2, S8, S11, S18, S20, S21, P2, P3。
