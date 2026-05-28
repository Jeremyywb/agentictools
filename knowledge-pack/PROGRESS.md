# Harness Engineering Knowledge Pack Progress

## 目标

围绕 harness 相关论文与工程资料做系统研究，形成可长期复用的 Harness Engineering Knowledge Pack，包括核心知识体系、skills、rules、templates、system-prompts、checklists。

## 工作规则

- 区分论文明确内容、隐含设计思想和工程实践推断。
- 重要结论必须标注来源类型和可信度。
- 证据不足时不强行下结论。
- 优先输出可执行约束、验证规则、清单、模板和 prompt，而不是泛泛总结。
- “创新开发”作为独立轨道处理，覆盖新 harness 设计、实验验证、推广门槛和回滚策略。
- 正文尽量使用中文；保留文件名、字段键名、URL、项目/论文原名和必要技术术语为英文。

## TODO

- [x] 建立工作目录结构。
- [x] 解析本地论文并抽取关键证据。
- [x] 建立初版证据来源注册表。
- [x] 完成高质量外部研究补强。
- [x] 蒸馏核心知识体系。
- [x] 生成 agent 可消费 artifacts。
- [x] 交叉审查、补证据、记录残余风险。

## 阶段 Review

### 阶段 1：论文解析

已完成。论文足以支撑 ETCLOVG 七层框架、model-harness pair 评估原则、五阶段 evaluation lifecycle、跨层 tradeoff 和 open problems。数值 benchmark 结论保留为引用证据，不泛化为普遍规律。

### 阶段 2：外部研究

已完成。已优先采用官方工程资料、官方仓库、官方规范与高质量论文；社区资料只作为低可信补充信号。

### 阶段 3：知识蒸馏

已完成。核心知识体系位于 `core/knowledge-system.md`，创新开发独立位于 `core/innovation-development.md`。

### 阶段 4：Agent 化输出

已完成。已生成 `skills/`、`rules/`、`templates/`、`system-prompts/`、`checklists/`。

### 最终 Review

已完成结构验收：

- `skills/`: 10 个独立技能文件，均包含 purpose、when_to_use、when_not_to_use、constraints、execution_steps、validation_rules、failure_handling、examples。
- `rules/`: 6 个强约束规则文件。
- `templates/`: 5 个模板。
- `system-prompts/`: 6 个角色提示词。
- `checklists/`: 5 个检查清单。

残余风险：

- 本地 survey 为 under review，部分 2026 论文或 benchmark 仍需后续复现。
- 外部来源已优先采用官方/论文；社区信号只作为低可信补充。
- 具体 sandbox/runtime 性能与安全取舍仍需按实际 workload 做本地评估。
