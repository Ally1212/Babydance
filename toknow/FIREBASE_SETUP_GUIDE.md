# Firebase 配置指南

## 概述

这个项目已经集成了 Firebase 的基础代码，但目前使用的是占位符配置。要在生产环境中使用，需要配置真实的 Firebase 项目。

## 当前状态

- ✅ Firebase 依赖已添加到 `pubspec.yaml`
- ✅ Firebase 服务类已创建 (`lib/services/firebase_service.dart`)
- ✅ Firebase 配置文件已存在 (`lib/firebase_options.dart`)
- ❌ 使用占位符配置，需要替换为真实配置
- ❌ 初始化代码被注释，需要启用

## 配置步骤

### 1. 创建 Firebase 项目

1. 访问 [Firebase Console](https://console.firebase.google.com/)
2. 点击"创建项目"或"添加项目"
3. 输入项目名称（建议使用：`flutter-flexible` 或你的应用名称）
4. 选择是否启用 Google Analytics（推荐启用）
5. 完成项目创建

### 2. 安装 FlutterFire CLI

```bash
# 安装 FlutterFire CLI
dart pub global activate flutterfire_cli

# 验证安装
flutterfire --version
```

### 3. 配置 Firebase 应用

在项目根目录运行：

```bash
# 登录 Firebase（如果还未登录）
firebase login

# 配置 Firebase 项目
flutterfire configure
```

按照提示操作：
1. 选择你刚创建的 Firebase 项目
2. 选择要支持的平台（Android、iOS、Web、macOS、Windows）
3. 输入应用包名（Android）和 Bundle ID（iOS）

### 4. 启用 Firebase 服务

在 Firebase Console 中启用需要的服务：

#### Crashlytics（崩溃报告）
1. 在 Firebase Console 中选择你的项目
2. 点击左侧菜单的 "Crashlytics"
3. 点击"开始使用"
4. 按照指引完成设置

#### 其他服务（可选）
- **Authentication**: 用户认证
- **Firestore**: 数据库
- **Cloud Storage**: 文件存储
- **Cloud Messaging**: 推送通知

### 5. 更新配置文件

FlutterFire CLI 会自动更新 `lib/firebase_options.dart` 文件，替换占位符配置。

### 6. 启用初始化代码

编辑 `lib/utils/app_setup/index.dart`，取消注释 Firebase 初始化代码：

```dart
/// 应用启动时的一次性初始化（异步）
Future<void> appSetupInitAsync() async {
  // 初始化Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 配置Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // 捕获异步错误
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
```

### 7. Android 特殊配置

#### 7.1 更新 `android/build.gradle`

确保包含 Google Services 插件：

```gradle
buildscript {
    dependencies {
        // ... 其他依赖
        classpath 'com.google.gms:google-services:4.4.0'
        classpath 'com.google.firebase:firebase-crashlytics-gradle:2.9.9'
    }
}
```

#### 7.2 更新 `android/app/build.gradle`

在文件末尾添加：

```gradle
apply plugin: 'com.google.gms.google-services'
apply plugin: 'com.google.firebase.crashlytics'
```

### 8. iOS 特殊配置

#### 8.1 确保 `ios/Runner/GoogleService-Info.plist` 存在

FlutterFire CLI 应该已经自动添加了这个文件。

#### 8.2 在 Xcode 中验证配置

1. 打开 `ios/Runner.xcworkspace`
2. 确保 `GoogleService-Info.plist` 在项目中
3. 检查 Bundle Identifier 是否与 Firebase 配置匹配

### 9. 测试配置

#### 9.1 运行应用

```bash
flutter run
```

#### 9.2 测试 Crashlytics

在应用中添加测试代码：

```dart
// 测试崩溃报告
FirebaseService.crash(); // 仅在调试模式下工作

// 测试错误记录
FirebaseService.recordError(
  Exception('测试错误'),
  StackTrace.current,
  reason: '测试 Firebase 配置',
);
```

#### 9.3 验证 Firebase Console

1. 运行应用并触发测试代码
2. 在 Firebase Console 的 Crashlytics 部分查看是否收到数据
3. 可能需要等待几分钟才能看到数据

## 环境配置

### 开发环境 vs 生产环境

建议为不同环境创建不同的 Firebase 项目：

1. **开发环境**: `flutter-flexible-dev`
2. **生产环境**: `flutter-flexible-prod`

可以通过环境变量或配置文件来切换不同的 Firebase 配置。

### 配置多环境

创建不同的配置文件：
- `lib/firebase_options_dev.dart`
- `lib/firebase_options_prod.dart`

然后在初始化时根据环境选择对应的配置。

## 常见问题

### Q: FlutterFire CLI 找不到项目
**A**: 确保已经登录 Firebase 并且有项目访问权限：
```bash
firebase login
firebase projects:list
```

### Q: Android 构建失败
**A**: 检查以下几点：
1. `google-services.json` 文件是否在 `android/app/` 目录下
2. Gradle 插件版本是否兼容
3. 包名是否与 Firebase 配置匹配

### Q: iOS 构建失败
**A**: 检查以下几点：
1. `GoogleService-Info.plist` 文件是否正确添加到 Xcode 项目
2. Bundle ID 是否与 Firebase 配置匹配
3. 是否在 Xcode 中正确配置了签名

### Q: Crashlytics 没有数据
**A**: 
1. 确保已在 Firebase Console 中启用 Crashlytics
2. 检查网络连接
3. 等待几分钟，数据可能有延迟
4. 确保应用不是在调试模式下运行（某些功能在调试模式下不工作）

## 安全注意事项

1. **不要提交敏感配置**: 虽然 `firebase_options.dart` 通常可以提交，但要确保不包含敏感信息
2. **使用环境变量**: 对于敏感配置，考虑使用环境变量
3. **配置安全规则**: 在 Firebase Console 中正确配置数据库和存储的安全规则

## 下一步

配置完成后，你可以：

1. 使用 `FirebaseService` 类记录错误和日志
2. 添加更多 Firebase 服务（如 Authentication、Firestore）
3. 配置推送通知
4. 设置 A/B 测试

## 相关文件

- `lib/utils/app_setup/index.dart` - Firebase 初始化
- `lib/services/firebase_service.dart` - Firebase 服务封装
- `lib/firebase_options.dart` - Firebase 配置
- `pubspec.yaml` - 依赖配置

---

配置完成后，记得取消注释 `lib/utils/app_setup/index.dart` 中的 TODO 代码！