# Context Rules

## 强约束

1. Active context 不是 memory。
2. 长期任务状态必须外部化到 durable artifacts。
3. 只预加载总是需要的信息。
4. 条件性信息必须 just-in-time retrieve。
5. 工具大输出使用后应替换为 compact reference。
6. Summary 必须保留 decisions、constraints、unresolved issues、evidence links。
7. Memory 必须包含 provenance、timestamp、confidence。
8. 未验证幻觉不得写入长期 memory。
9. Context compaction 前后必须可恢复关键状态。
10. Context policy 改动必须回归评估。

## 推荐上下文顺序

1. Stable system constraints。
2. Task objective and success criteria。
3. Current durable state summary。
4. Relevant retrieved evidence。
5. Current tool subset。
6. Recent high-signal trace or errors。

## 不得做

- 一次性塞入全部 repo 或全部历史。
- 让模型自己记住关键状态而不落盘。
- 把 untrusted web content 放在高优先级 instruction 区域。
- 把 credential、token、secret 放入 prompt。
- 无 provenance 地合并 memory。

## 来源

S0, S7, S8, S13, P4, P5, P6, P7。
