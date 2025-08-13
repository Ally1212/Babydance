# Flutter项目核心开发规范

## 项目架构

### 目录结构
```
lib/
├── pages/          # 页面组件
├── components/     # 可复用组件  
├── provider/       # Provider状态管理
├── utils/          # 工具类
├── services/       # 服务层
├── routes/         # 路由配置
├── models/         # 数据模型
└── config/         # 配置文件
```

### 文件命名规范
- 页面文件：`page_name.dart`
- Provider文件：`store_name.p.dart`
- 模型文件：`model_name.m.dart`
- 组件文件：小写+下划线

## 语言和回答规范

### 回答语言
- **主要语言**：中文（简体）
- **代码注释**：中文
- **技术术语**：保留英文原文，首次出现时提供中文解释
- **资料检索**：优先使用英文官方文档，但回答用中文

### MCP配置
```json
{
  "mcpServers": {
    "flutter-docs": {
      "command": "uvx",
      "args": ["flutter-documentation-mcp-server@latest"],
      "disabled": false,
      "autoApprove": ["search_documentation", "get_api_reference"]
    },
    "web-search": {
      "command": "uvx", 
      "args": ["web-search-mcp-server@latest"],
      "env": {"SEARCH_LANGUAGE": "en"},
      "disabled": false,
      "autoApprove": ["web_search"]
    }
  }
}
```

## 页面开发标准

### 标准页面模板
```dart
class PageName extends StatefulWidget {
  const PageName({super.key, this.params});
  final dynamic params;

  @override
  State<PageName> createState() => _PageNameState();
}

class _PageNameState extends State<PageName> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  FocusNode blankNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('页面标题')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(blankNode),
        child: contextWidget(),
      ),
    );
  }

  Widget contextWidget() {
    return Container(); // 页面内容
  }
}
```

### 必需要素
- 使用`AutomaticKeepAliveClientMixin`保持页面状态
- 实现键盘关闭处理（`blankNode`）
- 使用`flutter_screenutil`进行屏幕适配
- 支持路由参数传递

## Provider状态管理

### Provider类结构
```dart
class ExampleStore with ChangeNotifier {
  String _data = '';
  String get data => _data;
  
  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }
}
```

### 使用模式
```dart
// 监听数据变化
context.watch<CounterStore>().value

// 调用方法
context.read<CounterStore>().increment()

// Consumer包装
Consumer<CounterStore>(
  builder: (context, counter, child) => Text('${counter.value}'),
)
```

## 路由管理

### 路由配置
```dart
// route_name.dart
class RouteName {
  static const String home = '/home';
  static const String login = '/login';
}

// 路由跳转
Navigator.pushNamed(context, RouteName.login, arguments: {'data': 'value'});
```

## 组件开发

### 组件封装原则
- 单一职责，可复用，可配置
- 超过50行UI代码应提取为组件
- 支持主题色彩系统和屏幕适配

### 组件结构
```dart
class CustomComponent extends StatelessWidget {
  const CustomComponent({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
  });

  final String title;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(); // 组件实现
  }
}
```

## 工具类和服务

### 核心工具类
- `SpUtil` - 本地存储（SharedPreferences封装）
- `LogUtil` - 日志工具
- `TipsUtil` - 用户提示工具
- `UserUtil` - 用户相关工具

### 网络请求
- 使用Dio进行网络请求
- 统一错误处理和拦截器
- 支持请求日志和Header处理

### 工具类模式
```dart
// 单例模式
class UtilClass {
  static UtilClass? _instance;
  static UtilClass getInstance() => _instance ??= UtilClass._();
  UtilClass._();
}

// 静态方法
class StaticUtil {
  static String formatDate(DateTime date) { /* 实现 */ }
}
```

## 核心依赖

```yaml
dependencies:
  provider: 6.1.2           # 状态管理
  flutter_screenutil: 5.9.3 # 屏幕适配
  dio: 5.7.0               # 网络请求
  shared_preferences: 2.3.2 # 本地存储
```

## 开发最佳实践

### 性能优化
- 合理使用`Consumer`限制重建范围
- 使用`ListView.builder`构建长列表
- 实现图片懒加载和缓存

### 错误处理
- 统一异常处理机制
- 提供用户友好的错误提示
- 记录详细的错误日志

### 代码质量
- 遵循Flutter官方编码规范
- 为复杂组件编写单元测试
- 使用有意义的变量和方法命名

### 国际化支持
- 项目支持中文和英文
- 默认语言为中文（zh_CH）
- 使用Flutter官方国际化方案

## 调试和测试

### 开发工具
- 使用Provider DevTools进行状态调试
- 实现路由日志记录
- 支持MCP服务器状态监控

### 测试策略
- 为工具类编写单元测试
- 测试组件的不同参数组合
- 模拟网络请求进行集成测试