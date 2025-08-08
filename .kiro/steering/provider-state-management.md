---
inclusion: fileMatch
fileMatchPattern: 'lib/provider/**'
---

# Provider状态管理规范

## Provider架构模式

### 文件命名规范
- Provider类文件以`.p.dart`结尾
- 类名以`Store`结尾，如`ThemeStore`、`GlobalStore`
- 使用驼峰命名法

### Provider类结构
```dart
import 'package:flutter/material.dart';

class ExampleStore with ChangeNotifier {
  // 私有状态变量
  String _data = '';
  
  // 公共getter
  String get data => _data;
  
  // 状态更新方法
  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }
  
  // 异步操作
  Future<void> fetchData() async {
    // 异步逻辑
    _data = await someAsyncOperation();
    notifyListeners();
  }
}
```

## 现有Provider参考

### ThemeStore
管理全局主题状态：
- `setTheme(ThemeData themeName)` - 更新主题
- `getTheme` - 获取当前主题

### GlobalStore
全局应用状态管理。

### CounterStore
计数器状态管理示例：
- `increment()` - 增加计数
- `decrement()` - 减少计数

## Provider注册

所有Provider都在`providers_config.dart`中统一注册：

```dart
List<SingleChildWidget> providersConfig = [
  ChangeNotifierProvider<ThemeStore>(create: (_) => ThemeStore()),
  ChangeNotifierProvider<GlobalStore>(create: (_) => GlobalStore()),
  ChangeNotifierProvider<CounterStore>(create: (_) => CounterStore()),
];
```

## Provider使用模式

### 1. 监听数据变化
```dart
// 使用watch监听变化，会触发重建
Text('${context.watch<CounterStore>().value}')

// 使用Consumer包装需要重建的部分
Consumer<CounterStore>(
  builder: (context, counter, child) {
    return Text('${counter.value}');
  },
)
```

### 2. 调用方法
```dart
// 获取Provider实例并调用方法
Provider.of<CounterStore>(context).increment();

// 或者使用read（不监听变化）
context.read<CounterStore>().increment();
```

### 3. 在initState中使用
```dart
@override
void initState() {
  super.initState();
  // 使用listen: false避免在initState中监听
  Provider.of<ExampleStore>(context, listen: false).initData();
}
```

## 最佳实践

### 1. 状态设计原则
- 保持状态最小化
- 避免冗余状态
- 状态应该是不可变的

### 2. 方法命名规范
- 更新方法：`updateXxx`、`setXxx`
- 获取方法：`getXxx`（getter形式）
- 操作方法：`increment`、`decrement`、`toggle`等

### 3. 异步操作处理
```dart
Future<void> fetchData() async {
  try {
    _isLoading = true;
    notifyListeners();
    
    final result = await apiCall();
    _data = result;
    _error = null;
  } catch (e) {
    _error = e.toString();
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
```

### 4. 错误处理
- 在Provider中处理业务逻辑错误
- 提供错误状态给UI层
- 使用try-catch包装异步操作

### 5. 性能优化
- 合理使用`Consumer`限制重建范围
- 避免在build方法中调用会触发notifyListeners的方法
- 使用`Selector`进行精确监听

## 调试支持

- 在开发模式下添加日志输出
- 使用Provider DevTools进行状态调试
- 为复杂状态变化添加断言检查