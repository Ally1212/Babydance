---
inclusion: fileMatch
fileMatchPattern: 'lib/routes/**'
---

# 路由和导航规范

## 路由架构

### 文件结构
```
lib/routes/
├── route_name.dart         # 路由名称常量定义
├── routes_data.dart        # 路由配置映射
└── generate_route.dart     # 路由生成器
```

## 路由配置

### 1. 路由名称定义 (route_name.dart)
```dart
class RouteName {
  static const String appMain = '/app_main';
  static const String splashPage = '/splash';
  static const String login = '/login';
  static const String testDemo = '/test_demo';
  static const String error = '/error';
}
```

### 2. 路由映射 (routes_data.dart)
```dart
final String initialRoute = RouteName.splashPage;

final Map<String, StatefulWidget Function(BuildContext context, {dynamic params})> routesData = {
  RouteName.appMain: (context, {params}) => AppMain(params: params),
  RouteName.splashPage: (context, {params}) => SplashPage(),
  RouteName.login: (context, {params}) => Login(params: params),
  RouteName.testDemo: (context, {params}) => TestDemo(params: params),
  RouteName.error: (context, {params}) => ErrorPage(params: params),
};
```

### 3. 路由生成器 (generate_route.dart)
处理路由跳转逻辑和参数传递。

## 导航使用规范

### 1. 基础导航
```dart
// 跳转到新页面
Navigator.pushNamed(context, RouteName.targetPage);

// 替换当前页面
Navigator.pushReplacementNamed(context, RouteName.targetPage);

// 清空栈并跳转
Navigator.pushNamedAndRemoveUntil(
  context, 
  RouteName.targetPage, 
  (route) => false,
);

// 返回上一页
Navigator.pop(context);
```

### 2. 参数传递
```dart
// 传递参数
Navigator.pushNamed(
  context,
  RouteName.testDemo,
  arguments: {
    'data': '传递的数据',
    'id': 123,
    'user': userObject,
  },
);

// 接收参数
class TargetPage extends StatefulWidget {
  const TargetPage({super.key, this.params});
  final dynamic params;
  
  @override
  State<TargetPage> createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  @override
  Widget build(BuildContext context) {
    final args = widget.params;
    final data = args?['data'] ?? '';
    
    return Scaffold(
      body: Text('接收到的数据: $data'),
    );
  }
}
```

### 3. 返回值处理
```dart
// 等待页面返回结果
final result = await Navigator.pushNamed(
  context,
  RouteName.targetPage,
  arguments: {'data': 'input'},
);

// 返回结果
Navigator.pop(context, {'result': 'success'});
```

## 路由守卫和拦截

### 1. 登录状态检查
```dart
Route<dynamic> generateRoute(RouteSettings settings) {
  // 需要登录的页面列表
  final protectedRoutes = [
    RouteName.userProfile,
    RouteName.settings,
  ];
  
  if (protectedRoutes.contains(settings.name)) {
    final isLoggedIn = UserUtil.isLoggedIn();
    if (!isLoggedIn) {
      return MaterialPageRoute(
        builder: (context) => Login(params: {'redirect': settings.name}),
      );
    }
  }
  
  return _buildRoute(settings);
}
```

### 2. 权限检查
```dart
bool hasPermission(String routeName) {
  final userRole = UserUtil.getCurrentUserRole();
  final requiredPermissions = RoutePermissions.getPermissions(routeName);
  
  return requiredPermissions.every((permission) => 
    userRole.permissions.contains(permission)
  );
}
```

## 深度链接支持

### 1. URL路由映射
```dart
final Map<String, String> urlRoutes = {
  '/home': RouteName.appMain,
  '/login': RouteName.login,
  '/profile/:id': RouteName.userProfile,
};
```

### 2. 参数解析
```dart
Map<String, dynamic> parseUrlParams(String url, String pattern) {
  // URL参数解析逻辑
  final params = <String, dynamic>{};
  // 解析路径参数和查询参数
  return params;
}
```

## 页面转场动画

### 1. 自定义转场动画
```dart
Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
```

### 2. 平台特定动画
```dart
Route createPlatformRoute(Widget page) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (context) => page);
  } else {
    return MaterialPageRoute(builder: (context) => page);
  }
}
```

## 错误处理

### 1. 路由不存在处理
```dart
Route<dynamic> generateRoute(RouteSettings settings) {
  final routeBuilder = routesData[settings.name];
  
  if (routeBuilder == null) {
    return MaterialPageRoute(
      builder: (context) => ErrorPage(
        params: {'error': 'Route not found: ${settings.name}'},
      ),
    );
  }
  
  return MaterialPageRoute(
    builder: (context) => routeBuilder(context, params: settings.arguments),
  );
}
```

### 2. 参数验证
```dart
bool validateRouteParams(String routeName, dynamic params) {
  final requiredParams = RouteConfig.getRequiredParams(routeName);
  
  if (params == null && requiredParams.isNotEmpty) {
    return false;
  }
  
  for (final param in requiredParams) {
    if (params[param] == null) {
      return false;
    }
  }
  
  return true;
}
```

## 性能优化

### 1. 路由懒加载
```dart
final Map<String, Widget Function()> lazyRoutes = {
  RouteName.heavyPage: () => HeavyPage(),
};

Widget buildLazyRoute(String routeName) {
  final builder = lazyRoutes[routeName];
  return builder?.call() ?? ErrorPage();
}
```

### 2. 路由缓存
- 合理使用`AutomaticKeepAliveClientMixin`
- 避免重复创建相同页面实例
- 清理不需要的页面缓存

## 调试支持

### 1. 路由日志
```dart
class RouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    LogUtil.info('Route', 'Pushed: ${route.settings.name}');
  }
  
  @override
  void didPop(Route route, Route? previousRoute) {
    LogUtil.info('Route', 'Popped: ${route.settings.name}');
  }
}
```

### 2. 路由分析
- 记录页面访问统计
- 分析用户导航路径
- 监控页面性能指标