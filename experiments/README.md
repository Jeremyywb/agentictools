# Experiments

这里用于记录 harness 创新实验。实验记录必须能回答：这个机制是否真的改善了 model-harness pair？

## 建议目录结构

```text
experiments/YYYY-MM-topic/
  README.md
  baseline.md
  variant.md
  metrics.md
  traces.md
  decision.md
```

## 实验最小字段

- Hypothesis。
- Target ETCLOVG layer。
- Baseline configuration。
- Variant configuration。
- Metrics。
- Guardrails。
- Trace IDs。
- Failure attribution。
- Decision。

## 决策状态

- `reject`
- `revise`
- `shadow`
- `limited-rollout`
- `promote`

## 使用模板

从这里开始：[`innovation-experiment-template.md`](../knowledge-pack/templates/innovation-experiment-template.md)。
