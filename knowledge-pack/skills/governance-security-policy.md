# Skill: Governance And Security Policy

## purpose

为 agent 系统定义和执行 permissions、hooks、policies、hardening、audit、human oversight。

## when_to_use

- agent 修改文件、调用 API、访问 secrets、发送消息、部署代码、浏览网页或代表用户行动。
- 存在 prompt injection、excessive agency、supply-chain、data leakage 风险。
- 合规或审计重要。

## when_not_to_use

- 无工具、无 secrets、无外部效果、无持久状态的离线玩具例子。

## constraints

- enforcement 不能只依赖模型听话。
- 使用 least privilege。
- secrets 保持在 model context 外。
- policies 和 decisions 必须 versioned。
- destructive、irreversible、external、expensive、legally sensitive actions 必须升级。

## execution_steps

1. 按风险分类 tools 和 actions。
2. 定义 principal identity：user、agent、service、task、delegated authority。
3. 定义 policy：allow、deny、require approval、require verifier、require human。
4. 按需在 input 前、action 前、tool output 后、final response 前加入 hooks。
5. 使用 vault 或 execution-layer substitution 管理 secrets。
6. 添加 audit fields：principal、action、arguments、policy version、decision、trace ID、result。
7. 测试 prompt injection、tool poisoning、credential leakage、runaway loops。

## validation_rules

- 未授权动作 deterministic fail。
- prompts 和 traces 不含 secrets，除非已 redacted。
- audit logs 能解释谁授权了什么。
- policies readable、versioned、internally consistent。
- human approval prompt 有足够上下文且不过度弹出。

## failure_handling

- policy violation：停止动作，保留 trace，分类影响。
- secret exposure：轮换 credential 并审计访问。
- false positives 反复出现：细化 policy 并加测试。
- 风险歧义：升级而不是推断许可。

## examples

- workspace 外 `rm -rf` 必须 explicit human approval 或 deny。
- web-retrieved instructions 不得覆盖 system policy。
- deployment tool 在 tests pass 和 release approval 前不可见。
