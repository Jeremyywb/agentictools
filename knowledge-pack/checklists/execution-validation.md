# Checklist: Execution Validation

## Before Execution

- [ ] sandbox 或执行环境可用。
- [ ] dependencies 已验证。
- [ ] tool registry 正确。
- [ ] permissions 与任务匹配。
- [ ] budget/timeouts 设置。
- [ ] trace/logging 启用。

## During Execution

- [ ] 每个重要 action 有 trace。
- [ ] tool inputs 经过 validation。
- [ ] tool outputs 被正确处理或引用。
- [ ] progress artifact 更新。
- [ ] 异常已分类。
- [ ] retry 符合 policy。

## After Execution

- [ ] outcome 已验证。
- [ ] trajectory 已检查。
- [ ] cost/latency 已记录。
- [ ] policy compliance 已检查。
- [ ] residual risk 已记录。
- [ ] 需要的 regression tests 已添加或记录。
