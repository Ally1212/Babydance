---
inclusion: fileMatch
fileMatchPattern: 'lib/components/**'
---

# 组件开发规范

## 组件结构规范

### 目录组织
- 每个组件都应该有独立的目录
- 复杂组件可以包含子组件目录`components/`
- 组件目录名使用小写+下划线格式

### 组件文件命名
- 主组件文件与目录同名
- 子组件放在`components/`子目录中
- 相关工具类可以放在同级目录

## 现有组件参考

### BasicSafeArea
安全区域包装组件，用于处理刘海屏等适配问题。

### CustomIcons
自定义图标组件，使用自定义字体文件。

### ExitAppInterceptor
应用退出拦截器，包含退出提示动画。

### UpdateApp
应用更新组件，包含版本检查和更新界面。

### PageLoading
页面加载状态组件。

## 组件开发最佳实践

### 1. 组件封装原则
- 单一职责：每个组件只负责一个功能
- 可复用性：组件应该能在不同场景下使用
- 可配置性：通过参数控制组件行为和样式

### 2. 参数设计
```dart
class CustomComponent extends StatelessWidget {
  const CustomComponent({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
    this.textStyle,
  });

  final String title;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final TextStyle? textStyle;
}
```

### 3. 样式处理
- 使用`flutter_screenutil`进行尺寸适配
- 支持主题色彩系统
- 提供默认样式和自定义样式选项

### 4. 状态管理
- 简单组件使用`StatelessWidget`
- 需要状态的组件使用`StatefulWidget`
- 复杂状态使用Provider管理

### 5. 事件处理
- 使用回调函数处理用户交互
- 支持可选的事件处理器
- 提供清晰的事件参数

## 组件文档要求

每个组件都应该包含：
- 功能说明
- 参数说明
- 使用示例
- 注意事项

## 测试要求

- 为复杂组件编写单元测试
- 测试不同参数组合的渲染结果
- 测试用户交互行为