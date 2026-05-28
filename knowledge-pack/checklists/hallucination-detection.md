# Checklist: Hallucination Detection

## Source Claims

- [ ] 每个重要事实有来源。
- [ ] 来源类型和可信度已标记。
- [ ] 没有把 inference 写成 fact。
- [ ] 没有把社区轶事写成硬规则。

## Code/Artifact Claims

- [ ] 文件路径真实存在。
- [ ] 行为由代码、测试或 trace 支持。
- [ ] 没有凭记忆描述未检查的实现。
- [ ] 生成内容与当前 repo 状态一致。

## Evaluation Claims

- [ ] benchmark 配置已记录。
- [ ] grader/judge version 已记录。
- [ ] 没有只用 final score 下结论。
- [ ] variance 或不确定性已说明。

## Memory Claims

- [ ] memory 有 provenance。
- [ ] stale assumptions 已检查。
- [ ] conflicting evidence 已处理。
- [ ] 未验证内容未写入长期 memory。

## Red Flags

- [ ] “显然/一般/业界都”但无来源。
- [ ] 数值提升无 benchmark 配置。
- [ ] 引用不存在或无法打开。
- [ ] 工程建议没有验证路径。
