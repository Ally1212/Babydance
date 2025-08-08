# Flutter项目开发规范

## 项目架构

这是一个基于Flutter的移动应用项目，采用以下架构模式：

### 目录结构
- `lib/pages/` - 页面组件
- `lib/components/` - 可复用组件
- `lib/provider/` - Provider状态管理
- `lib/utils/` - 工具类
- `lib/config/` - 配置文件
- `lib/routes/` - 路由配置
- `lib/models/` - 数据模型
- `lib/services/` - 服务层

### 状态管理
项目使用Provider进行状态管理：
- 所有Provider都在`providers_config.dart`中统一配置
- Provider类命名以`Store`结尾，如`ThemeStore`、`CounterStore`
- 使用`ChangeNotifier`混入类实现状态变更通知

## 编码规范

### 文件命名
- 页面文件：小写+下划线，如`home.dart`
- Provider文件：以`.p.dart`结尾，如`theme_store.p.dart`
- 模型文件：以`.m.dart`结尾，如`login.m.dart`
- 组件文件：小写+下划线，放在对应功能目录下

### 代码风格
- 使用`flutter_screenutil`进行屏幕适配
- 所有页面继承`StatefulWidget`
- 使用`AutomaticKeepAliveClientMixin`保持页面状态
- 空白处点击关闭键盘的通用处理模式

### 组件开发
- 可复用组件放在`lib/components/`目录
- 每个组件有独立的目录
- 复杂组件可以有子组件目录`components/`

### 路由管理
- 路由名称定义在`route_name.dart`
- 路由配置在`routes_data.dart`
- 使用命名路由进行页面跳转
- 支持路由参数传递

### 主题管理
- 使用`ThemeStore`管理全局主题
- 主题文件放在`constants/themes/`目录
- 支持多主题切换

### 工具类使用
- `SpUtil` - SharedPreferences封装
- `LogUtil` - 日志工具
- `TipsUtil` - 提示工具
- `UserUtil` - 用户相关工具

## 依赖管理

### 核心依赖
- `provider: 6.1.2` - 状态管理
- `flutter_screenutil: 5.9.3` - 屏幕适配
- `dio: 5.7.0` - 网络请求
- `shared_preferences: 2.3.2` - 本地存储

### 开发规范
- 新增依赖需要在`pubspec.yaml`中明确版本号
- 优先使用项目已有的工具类和组件
- 遵循Flutter官方编码规范

## 页面开发模式

### 标准页面结构
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
    // 页面内容
  }
}
```

### Provider使用模式
```dart
// 获取Provider数据
context.watch<ProviderName>().property

// 调用Provider方法
Provider.of<ProviderName>(context).method()
```

## 国际化支持
- 项目支持中文和英文
- 默认语言为中文（zh_CH）
- 使用Flutter官方国际化方案