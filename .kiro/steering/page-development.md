---
inclusion: fileMatch
fileMatchPattern: 'lib/pages/**'
---

# 页面开发规范

## 页面结构标准

### 基础页面模板
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageName extends StatefulWidget {
  const PageName({super.key, this.params});
  final dynamic params;

  @override
  State<PageName> createState() => _PageNameState();
}

class _PageNameState extends State<PageName> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  FocusNode blankNode = FocusNode(); // 响应空白处的焦点

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('页面标题'),
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(blankNode);
        },
        child: contextWidget(),
      ),
    );
  }

  Widget contextWidget() {
    // 页面主要内容
    return Container();
  }
}
```

## 页面分类和规范

### 1. 主要页面 (app_main)
- `AppMain` - 主框架页面，包含底部导航
- `Home` - 首页
- `Hot` - 热门页面
- `Search` - 搜索页面
- `MyPersonal` - 个人中心

### 2. 功能页面
- `Login` - 登录页面
- `Splash` - 启动页面
- `TestDemo` - 测试演示页面
- `ErrorPage` - 错误页面

## 页面开发要求

### 1. 必需的Mixin
```dart
class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 保持页面状态
}
```

### 2. 键盘处理
每个页面都应该包含键盘关闭处理：
```dart
FocusNode blankNode = FocusNode();

GestureDetector(
  onTap: () => FocusScope.of(context).requestFocus(blankNode),
  child: pageContent,
)
```

### 3. 屏幕适配
使用`flutter_screenutil`进行尺寸适配：
```dart
Text(
  'text',
  style: TextStyle(fontSize: 22.sp),
)

Container(
  width: 100.w,
  height: 50.h,
  margin: EdgeInsets.only(top: 10.h),
)
```

### 4. 路由跳转
使用命名路由进行页面跳转：
```dart
Navigator.pushNamed(
  context,
  RouteName.targetPage,
  arguments: {'data': 'parameter'},
);
```

### 5. Provider使用
在页面中正确使用Provider：
```dart
// 监听数据变化
Text('${context.watch<CounterStore>().value}')

// 调用Provider方法
final counter = Provider.of<CounterStore>(context);
counter.increment();
```

## 页面组件化

### 1. 组件提取原则
- 超过50行的UI代码应该提取为独立组件
- 可复用的UI元素必须提取为组件
- 复杂的业务逻辑应该封装为组件

### 2. 组件目录结构
```
lib/pages/page_name/
├── page_name.dart          # 主页面文件
├── components/             # 页面专用组件
│   ├── component1.dart
│   └── component2.dart
└── provider/              # 页面专用Provider
    └── page_store.p.dart
```

### 3. 按钮组件示例
```dart
Widget _button(String text, {VoidCallback? onPressed}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 22.sp),
      ),
    ),
  );
}
```

## 页面生命周期

### 1. 初始化
```dart
@override
void initState() {
  super.initState();
  // 页面初始化逻辑
}
```

### 2. 数据加载
```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  // 依赖变化时的处理
}
```

### 3. 资源清理
```dart
@override
void dispose() {
  // 清理资源
  blankNode.dispose();
  super.dispose();
}
```

## 错误处理

### 1. 页面级错误处理
- 使用try-catch包装可能出错的操作
- 提供用户友好的错误提示
- 记录错误日志用于调试

### 2. 网络请求错误
- 显示加载状态
- 处理网络异常
- 提供重试机制

## 性能优化

### 1. 列表优化
- 使用`ListView.builder`构建长列表
- 实现懒加载和分页
- 合理使用`AutomaticKeepAliveClientMixin`

### 2. 图片优化
- 使用合适的图片格式和尺寸
- 实现图片缓存机制
- 懒加载图片资源

### 3. 状态管理优化
- 避免不必要的页面重建
- 使用`Consumer`精确控制重建范围
- 合理设计Provider的粒度