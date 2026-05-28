# Skill: Execution Sandbox Design

## purpose

设计或评审 agent action 的执行环境，重点关注 security、reproducibility、liveness、scalability。

## when_to_use

- agent 执行代码、shell、browser/desktop action、文件修改或网络调用。
- evaluation 需要可 reset 环境。
- 存在多租户或不可信 workload。
- 权限弹窗阻碍长期自治执行。

## when_not_to_use

- 无工具的只读问答。
- agent 不执行任何外部动作的人类辅助流程。

## constraints

- 隔离强度必须匹配 threat model。
- credential 不得进入 model context；进入 sandbox 也必须最小化和限域。
- 环境 reset 必须可复现。
- 文件、网络和资源边界必须显式。
- evaluation metadata 必须记录 sandbox/runtime version。

## execution_steps

1. 分类 workload：code、browser、desktop、data、API、mixed。
2. 分类 threat model：trusted local、prompt-injected、untrusted code、multi-tenant、adversarial。
3. 选择 substrate：OS permission boundary、container、microVM、browser env、desktop VM、Kubernetes sandbox、managed sandbox。
4. 定义 filesystem allowlist、network egress、package install policy、secrets policy、CPU/memory/time limits、reset procedure。
5. 添加 command、file、network、exit code、duration、policy decision 的 trace hooks。
6. 写 readiness checks 和 failure recovery。
7. 将 sandbox 配置纳入 evaluation metadata。

## validation_rules

- fresh sandbox 可运行标准任务。
- 被禁止动作能被 deterministic deny。
- reset 能回到已知 baseline。
- 日志包含 command、result、policy、trace ID。
- resource limits 被实际执行。

## failure_handling

- dependency drift：从 pinned image 或 lockfile 重建。
- sandbox crash：重新 provision，并从 durable state resume。
- denied action：先判断 policy 错还是 task plan 错，再决定是否升级。
- suspicious behavior：撤销 credential，保留 logs，轮换 secrets。

## examples

- 本地 coding assistant：OS-level path allowlist + network proxy 可能足够。
- 公共 code-execution 服务：优先 microVM 或同等强隔离。
- Browser benchmark：必须 reset app state 和 browser profile。
