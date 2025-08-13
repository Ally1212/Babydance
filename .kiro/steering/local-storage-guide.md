---
inclusion: manual
---

# 本地存储使用指南

## 核心原则

**所有本地存储操作必须使用项目封装的 `SpUtil` 工具类，严禁直接使用 `SharedPreferences`**

## SpUtil 工具类详解

### 基本用法

```dart
import '../utils/tool/sp_util.dart';

class ExampleStore extends ChangeNotifier {
  static const String _keyExample = 'example_data';
  
  // 保存数据
  Future<void> saveData(String value) async {
    final spUtil = await SpUtil.getInstance();
    await spUtil.setData(_keyExample, value);
  }
  
  // 读取数据
  Future<String> loadData() async {
    final spUtil = await SpUtil.getInstance();
    return await spUtil.getData<String>(_keyExample, defValue: '');
  }
}
```

### 支持的数据类型

#### 基础类型
```dart
// String
await spUtil.setData('name', 'John');
final name = await spUtil.getData<String>('name', defValue: '');

// int
await spUtil.setData('age', 25);
final age = await spUtil.getData<int>('age', defValue: 0);

// double
await spUtil.setData('price', 99.99);
final price = await spUtil.getData<double>('price', defValue: 0.0);

// bool
await spUtil.setData('isEnabled', true);
final isEnabled = await spUtil.getData<bool>('isEnabled', defValue: false);
```

#### 复杂类型
```dart
// Map
final userInfo = {'name': 'John', 'age': 25, 'email': 'john@example.com'};
await spUtil.setMapData('userInfo', userInfo);
final savedUserInfo = await spUtil.getMap<Map<String, dynamic>>('userInfo');

// List
final tags = ['flutter', 'dart', 'mobile'];
await spUtil.setListData('tags', tags);
final savedTags = await spUtil.getList<String>('tags');

// 自定义对象（需要序列化）
final user = User(name: 'John', age: 25);
await spUtil.setMapData('user', user.toJson());
final userData = await spUtil.getMapCustom('user', (data) => User.fromJson(data));
```

### 工具方法

```dart
// 检查键是否存在
final exists = await spUtil.hasKey('key');

// 获取所有键
final keys = await spUtil.getKeys();

// 删除指定键
await spUtil.remove('key');

// 清空所有数据
await spUtil.clear();

// 重新加载数据
await spUtil.reload();
```

## 命名规范

### 键名规范
- 使用有意义的前缀区分模块
- 使用下划线分隔单词
- 定义为常量避免硬编码

```dart
class StorageKeys {
  // 用户相关
  static const String userToken = 'user_token';
  static const String userInfo = 'user_info';
  static const String userPreferences = 'user_preferences';
  
  // 应用设置
  static const String appLocale = 'app_locale';
  static const String appTheme = 'app_theme';
  static const String appVersion = 'app_version';
  
  // 缓存数据
  static const String cacheData = 'cache_data';
  static const String cacheTimestamp = 'cache_timestamp';
}
```

### Provider 中的使用模式

```dart
class UserStore extends ChangeNotifier {
  static const String _tokenKey = 'user_token';
  static const String _userInfoKey = 'user_info';
  
  String _token = '';
  Map<String, dynamic> _userInfo = {};
  
  String get token => _token;
  Map<String, dynamic> get userInfo => _userInfo;
  
  UserStore() {
    _loadUserData();
  }
  
  // 登录保存用户数据
  Future<void> login(String token, Map<String, dynamic> userInfo) async {
    _token = token;
    _userInfo = userInfo;
    notifyListeners();
    
    final spUtil = await SpUtil.getInstance();
    await spUtil.setData(_tokenKey, token);
    await spUtil.setMapData(_userInfoKey, userInfo);
  }
  
  // 加载用户数据
  Future<void> _loadUserData() async {
    final spUtil = await SpUtil.getInstance();
    _token = await spUtil.getData<String>(_tokenKey, defValue: '');
    _userInfo = await spUtil.getMap<Map<String, dynamic>>(_userInfoKey, defValue: {});
    notifyListeners();
  }
  
  // 登出清除数据
  Future<void> logout() async {
    _token = '';
    _userInfo = {};
    notifyListeners();
    
    final spUtil = await SpUtil.getInstance();
    await spUtil.remove(_tokenKey);
    await spUtil.remove(_userInfoKey);
  }
}
```

## 最佳实践

### 1. 错误处理
```dart
Future<void> saveDataSafely(String key, dynamic value) async {
  try {
    final spUtil = await SpUtil.getInstance();
    await spUtil.setData(key, value);
  } catch (e) {
    print('保存数据失败: $e');
    // 处理错误，可能需要用户重试
  }
}
```

### 2. 数据验证
```dart
Future<String> loadValidatedData(String key) async {
  final spUtil = await SpUtil.getInstance();
  final data = await spUtil.getData<String>(key, defValue: '');
  
  // 验证数据有效性
  if (data.isEmpty || !isValidData(data)) {
    return getDefaultValue();
  }
  
  return data;
}
```

### 3. 缓存过期处理
```dart
class CacheManager {
  static const String _dataKey = 'cache_data';
  static const String _timestampKey = 'cache_timestamp';
  static const int _cacheValidDuration = 24 * 60 * 60 * 1000; // 24小时
  
  Future<String?> getCachedData() async {
    final spUtil = await SpUtil.getInstance();
    final timestamp = await spUtil.getData<int>(_timestampKey, defValue: 0);
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    
    // 检查缓存是否过期
    if (currentTime - timestamp > _cacheValidDuration) {
      await clearCache();
      return null;
    }
    
    return await spUtil.getData<String>(_dataKey, defValue: '');
  }
  
  Future<void> setCachedData(String data) async {
    final spUtil = await SpUtil.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    
    await spUtil.setData(_dataKey, data);
    await spUtil.setData(_timestampKey, currentTime);
  }
  
  Future<void> clearCache() async {
    final spUtil = await SpUtil.getInstance();
    await spUtil.remove(_dataKey);
    await spUtil.remove(_timestampKey);
  }
}
```

## 常见使用场景

### 1. 语言设置持久化
```dart
class LocaleStore extends ChangeNotifier {
  static const String _localeKey = 'app_locale';
  
  Future<void> setLocale(Locale locale) async {
    final spUtil = await SpUtil.getInstance();
    await spUtil.setData(_localeKey, locale.languageCode);
  }
  
  Future<Locale> getLocale() async {
    final spUtil = await SpUtil.getInstance();
    final code = await spUtil.getData<String>(_localeKey, defValue: 'zh');
    return Locale(code);
  }
}
```

### 2. 主题设置
```dart
class ThemeStore extends ChangeNotifier {
  static const String _themeKey = 'app_theme_mode';
  
  Future<void> setThemeMode(ThemeMode mode) async {
    final spUtil = await SpUtil.getInstance();
    await spUtil.setData(_themeKey, mode.index);
  }
  
  Future<ThemeMode> getThemeMode() async {
    final spUtil = await SpUtil.getInstance();
    final index = await spUtil.getData<int>(_themeKey, defValue: 0);
    return ThemeMode.values[index];
  }
}
```

### 3. 用户偏好设置
```dart
class UserPreferences {
  static const String _notificationKey = 'notification_enabled';
  static const String _autoSaveKey = 'auto_save_enabled';
  
  Future<void> setNotificationEnabled(bool enabled) async {
    final spUtil = await SpUtil.getInstance();
    await spUtil.setData(_notificationKey, enabled);
  }
  
  Future<bool> isNotificationEnabled() async {
    final spUtil = await SpUtil.getInstance();
    return await spUtil.getData<bool>(_notificationKey, defValue: true);
  }
}
```

## 注意事项

1. **异步操作**：所有 SpUtil 方法都是异步的，必须使用 `await`
2. **类型安全**：使用泛型指定数据类型，避免类型错误
3. **默认值**：总是提供合理的默认值，防止空值异常
4. **键名管理**：使用常量管理键名，避免拼写错误
5. **数据大小**：避免存储过大的数据，考虑使用文件存储
6. **敏感数据**：敏感信息应该加密后再存储

## 迁移指南

如果项目中有直接使用 `SharedPreferences` 的代码，按以下步骤迁移：

### 迁移前
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('key', 'value');
final value = prefs.getString('key') ?? '';
```

### 迁移后
```dart
final spUtil = await SpUtil.getInstance();
await spUtil.setData('key', 'value');
final value = await spUtil.getData<String>('key', defValue: '');
```

这样可以确保项目中所有本地存储操作的一致性和可维护性。