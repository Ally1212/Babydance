# Flutter 国际化配置说明

## 配置文件

### 1. pubspec.yaml
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any

flutter:
  generate: true
```

### 2. l10n.yaml
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
```

## ARB 文件

### 英文模板 (lib/l10n/app_en.arb)
```json
{
  "@@locale": "en",
  "appTitle": "Flutter Flexible",
  "hello": "Hello",
  "welcome": "Welcome to Flutter Flexible"
}
```

### 中文翻译 (lib/l10n/app_zh.arb)
```json
{
  "@@locale": "zh",
  "appTitle": "Flutter 灵活框架",
  "hello": "你好",
  "welcome": "欢迎使用 Flutter 灵活框架"
}
```

## 使用方法

### 1. 在 Widget 中使用
```dart
import '../l10n/app_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Text(localizations.hello);
  }
}
```

### 2. 使用 LocaleStore 切换语言
```dart
// 切换到英文
context.read<LocaleStore>().setLocale(const Locale('en'));

// 切换到中文
context.read<LocaleStore>().setLocale(const Locale('zh'));

// 快速切换语言
context.read<LocaleStore>().toggleLanguage();
```

### 3. 使用便捷工具类
```dart
import '../utils/localization_helper.dart';

// 直接获取文本
String greeting = LocalizationHelper.hello(context);
```

## 生成本地化文件

执行以下命令生成本地化文件：
```bash
flutter pub get
flutter gen-l10n
```

## 功能特性

- ✅ 支持中英文切换
- ✅ 语言状态持久化存储
- ✅ Provider 状态管理
- ✅ 专用语言设置页面
- ✅ 便捷工具类
- ✅ 一键切换语言按钮

## 添加新语言

1. 在 `lib/l10n/` 目录下创建新的 ARB 文件，如 `app_ja.arb`
2. 添加翻译内容
3. 运行 `flutter gen-l10n` 重新生成
4. 在 `LocaleStore` 中添加对应的语言支持