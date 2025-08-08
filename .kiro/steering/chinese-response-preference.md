# 中文回答偏好设置

## 语言使用规范

### 回答语言要求
- **主要回答语言**: 中文（简体）
- **代码注释**: 中文
- **变量命名**: 英文（遵循编程规范）
- **文档说明**: 中文
- **错误提示**: 中文

### 技术术语处理
- 保留英文技术术语的原文，并在首次出现时提供中文解释
- 例如：Provider（状态管理器）、Widget（组件）、StatefulWidget（有状态组件）

## 资料检索策略

### 优先级顺序
1. **英文官方文档** - 最权威和最新的技术信息
2. **英文技术博客** - 深度技术分析
3. **GitHub官方仓库** - 源码和示例
4. **Stack Overflow英文版** - 问题解决方案

### 检索关键词策略
```
// 使用英文关键词进行搜索
搜索: "Flutter StatefulWidget lifecycle methods"
而不是: "Flutter 有状态组件生命周期方法"

搜索: "Dart async await best practices"  
而不是: "Dart 异步等待最佳实践"
```

### 信息处理流程
1. 使用英文关键词检索资料
2. 获取英文技术文档和资源
3. 理解和分析英文内容
4. 将理解的内容用中文表达
5. 保留重要的英文术语

## MCP服务配置示例

### 搜索配置
```json
{
  "mcpServers": {
    "web-search": {
      "command": "uvx",
      "args": ["web-search-mcp-server@latest"],
      "env": {
        "SEARCH_LANGUAGE": "en",
        "RESULT_LANGUAGE": "zh-CN",
        "PREFER_OFFICIAL_DOCS": "true"
      },
      "disabled": false,
      "autoApprove": ["web_search", "search_documentation"]
    }
  }
}
```

## 回答格式规范

### 技术解释格式
```
## Widget生命周期（Widget Lifecycle）

在Flutter中，StatefulWidget有以下主要生命周期方法：

1. **initState()** - 初始化状态
   - 用途：组件初始化时调用
   - 时机：在build()方法之前调用一次

2. **build()** - 构建UI
   - 用途：构建组件的UI界面
   - 时机：每次状态改变时调用
```

### 代码示例格式
```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();
    // 初始化逻辑
    print('组件初始化完成');
  }

  @override
  Widget build(BuildContext context) {
    // 构建UI界面
    return Container(
      child: Text('Hello World'),
    );
  }
}
```

### 错误处理说明格式
```
## 常见错误及解决方案

### 错误：RenderFlex overflowed
**原因**：容器内容超出可用空间
**解决方案**：
1. 使用Flexible或Expanded包装子组件
2. 设置overflow属性
3. 使用SingleChildScrollView添加滚动
```

## 文档引用规范

### 引用英文文档时的格式
```
根据Flutter官方文档（Flutter Official Documentation）的说明，
StatefulWidget的生命周期包括以下几个阶段...

参考资料：
- Flutter官方文档: https://docs.flutter.dev/
- Dart语言规范: https://dart.dev/guides
```

### 翻译技术概念
- **Widget** → 组件（Widget）
- **State Management** → 状态管理（State Management）
- **Provider** → 状态管理器（Provider）
- **Build Context** → 构建上下文（Build Context）

## 实际应用示例

### 询问技术问题时
```
用户问题：如何在Flutter中实现状态管理？

回答格式：
在Flutter中实现状态管理有多种方式，最常用的是Provider模式。

## Provider状态管理

Provider是Flutter推荐的状态管理解决方案...

### 基本用法
[提供中文解释和代码示例]

### 最佳实践
[基于英文文档的最佳实践，用中文说明]
```

## 质量保证

### 回答质量标准
- 技术准确性：基于最新的英文官方文档
- 语言流畅性：使用自然的中文表达
- 实用性：提供可直接使用的代码示例
- 完整性：包含必要的上下文和注意事项

### 持续改进
- 定期更新技术知识库
- 优化中文技术术语表达
- 收集用户反馈改进回答质量