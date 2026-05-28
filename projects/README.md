# Projects

这里用于承载未来具体的 harness 创新项目。`knowledge-pack/` 是知识层，`projects/` 是实现层。

## 建议目录结构

```text
projects/<project-name>/
  README.md
  DESIGN.md
  IMPLEMENTATION.md
  EVAL.md
  traces/
  src/
  tests/
```

## 每个项目必须说明

- 要解决的 harness 问题。
- 涉及的 ETCLOVG layer。
- baseline。
- proposed mechanism。
- evaluation plan。
- governance/security risk。
- rollback strategy。

## 推荐项目方向

| 方向 | 说明 |
|---|---|
| Runtime Sandbox | 可 reset、可审计、可扩展的 agent execution substrate |
| Trace-Native Evaluation | 从 trace 直接生成 outcome、trajectory、failure attribution |
| MCP Tool Router | 动态 tool routing、schema validation、permission-aware exposure |
| Context Memory Auditor | provenance、staleness、contradiction handling |
| Multi-Agent Handoff | intent、constraints、permissions、artifacts、trace 的标准化交接 |
