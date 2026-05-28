# Retry Policy

## 核心原则

Retry 不是通用修复。只有 transient failure 才适合直接 retry；semantic failure 必须先归因。

## 可直接有限重试

- 临时网络错误。
- sandbox 冷启动失败。
- rate limit 后可等待重试。
- flaky dependency fetch。
- 短暂服务不可用。

## 不得盲目重试

- tool schema validation failure。
- permission denied。
- test failure。
- evaluator disagreement。
- agent loop。
- context loss。
- policy violation。
- suspected prompt injection。

## Retry 前检查

1. 失败层级：E/T/C/L/O/V/G 哪一层？
2. 是否 transient？
3. retry 是否会产生副作用？
4. 是否需要 reset 环境？
5. 是否需要降低权限或隔离？
6. 是否会放大成本？
7. 是否已有 trace 足够诊断？

## 默认限制

- 同一 transient failure 最多 2 次自动重试。
- 每次 retry 必须记录 reason、attempt、changed variable。
- retry 后仍失败，升级为 failure attribution，不继续循环。
- destructive action 不自动 retry，除非操作幂等且有明确补偿机制。

## 来源

S0, S8, S11, S13, S20, S21。
