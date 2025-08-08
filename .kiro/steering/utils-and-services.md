---
inclusion: fileMatch
fileMatchPattern: 'lib/utils/**'
---

# 工具类和服务开发规范

## 工具类架构

### 目录结构
```
lib/utils/
├── app_setup/              # 应用初始化
├── dio/                    # 网络请求
│   └── interceptors/       # 请求拦截器
├── tool/                   # 通用工具类
└── index.dart             # 工具类导出文件
```

## 现有工具类

### 1. SpUtil - 本地存储工具
SharedPreferences的封装，提供类型安全的本地存储：

```dart
// 基础数据类型存储
await SpUtil.getInstance().setData<String>('key', 'value');
String value = await SpUtil.getInstance().getData<String>('key', defValue: '');

// 复杂数据类型存储
await SpUtil.getInstance().setMapData('user', userMap);
Map user = await SpUtil.getInstance().getMap('user');

// List数据存储
await SpUtil.getInstance().setListData('items', itemList);
List items = await SpUtil.getInstance().getList('items');
```

### 2. LogUtil - 日志工具
统一的日志输出管理。

### 3. TipsUtil - 提示工具
统一的用户提示管理（Toast、Dialog等）。

### 4. UserUtil - 用户工具
用户相关的通用操作。

### 5. DeviceInfoUtil - 设备信息工具
获取设备相关信息。

### 6. PermUtil - 权限工具
权限请求和管理。

## 网络请求工具 (Dio)

### 基础配置
```dart
// 请求实例配置
final dio = Dio();
dio.interceptors.add(HeaderInterceptor());
dio.interceptors.add(LogInterceptor());
```

### 拦截器规范
- `HeaderInterceptor` - 请求头处理
- `LogInterceptor` - 请求日志记录
- 错误处理拦截器

### 请求封装
```dart
class ApiService {
  static Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      return await dio.get(path, queryParameters: params);
    } catch (e) {
      throw DioErrorUtil.handleError(e);
    }
  }
}
```

## 工具类开发规范

### 1. 单例模式
对于需要全局唯一实例的工具类：
```dart
class UtilClass {
  static UtilClass? _instance;
  
  static UtilClass getInstance() {
    _instance ??= UtilClass._();
    return _instance!;
  }
  
  UtilClass._();
}
```

### 2. 静态方法工具类
对于无状态的工具方法：
```dart
class StaticUtil {
  static String formatDate(DateTime date) {
    // 格式化逻辑
  }
  
  static bool isValidEmail(String email) {
    // 验证逻辑
  }
}
```

### 3. 异步操作处理
```dart
class AsyncUtil {
  static Future<T> safeAsync<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } catch (e) {
      LogUtil.error('AsyncUtil', e.toString());
      rethrow;
    }
  }
}
```

### 4. 错误处理
```dart
class ErrorUtil {
  static void handleError(dynamic error, {String? context}) {
    final errorMessage = _formatError(error);
    LogUtil.error(context ?? 'Unknown', errorMessage);
    
    // 根据错误类型进行不同处理
    if (error is NetworkException) {
      TipsUtil.showNetworkError();
    } else {
      TipsUtil.showGeneralError(errorMessage);
    }
  }
}
```

## 服务层开发

### 1. API服务封装
```dart
class UserService {
  static Future<UserModel> login(String username, String password) async {
    final response = await ApiUtil.post('/login', {
      'username': username,
      'password': password,
    });
    
    return UserModel.fromJson(response.data);
  }
  
  static Future<List<UserModel>> getUserList() async {
    final response = await ApiUtil.get('/users');
    return (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }
}
```

### 2. 缓存服务
```dart
class CacheService {
  static const String _userKey = 'cached_user';
  
  static Future<void> cacheUser(UserModel user) async {
    await SpUtil.getInstance().setMapData(_userKey, user.toJson());
  }
  
  static Future<UserModel?> getCachedUser() async {
    final userData = await SpUtil.getInstance().getMap(_userKey);
    return userData.isNotEmpty ? UserModel.fromJson(userData) : null;
  }
}
```

## 工具类测试

### 1. 单元测试
```dart
void main() {
  group('SpUtil Tests', () {
    test('should store and retrieve string data', () async {
      final spUtil = await SpUtil.getInstance();
      await spUtil.setData('test_key', 'test_value');
      final result = await spUtil.getData<String>('test_key');
      expect(result, equals('test_value'));
    });
  });
}
```

### 2. 模拟测试
对于依赖外部服务的工具类，使用Mock进行测试。

## 性能考虑

### 1. 懒加载
- 工具类实例化采用懒加载模式
- 避免应用启动时加载所有工具类

### 2. 缓存策略
- 合理使用内存缓存
- 设置缓存过期时间
- 提供缓存清理机制

### 3. 异步优化
- 使用Future和async/await处理异步操作
- 避免阻塞主线程
- 合理使用Isolate处理计算密集型任务