---
inclusion: manual
---

# 国际化（i18n）开发指南

## 项目国际化配置

### 基础配置文件

#### pubspec.yaml
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any

flutter:
  generate: true
```

#### l10n.yaml
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
```

### ARB 文件结构

#### 英文模板 (lib/l10n/app_en.arb)
```json
{
  "@@locale": "en",
  "appTitle": "Flutter Flexible",
  "@appTitle": {
    "description": "The title of the application"
  },
  "hello": "Hello",
  "@hello": {
    "description": "A greeting message"
  },
  "welcomeUser": "Welcome, {username}!",
  "@welcomeUser": {
    "description": "Welcome message with username",
    "placeholders": {
      "username": {
        "type": "String",
        "example": "John"
      }
    }
  }
}
```

#### 中文翻译 (lib/l10n/app_zh.arb)
```json
{
  "@@locale": "zh",
  "appTitle": "Flutter 灵活框架",
  "hello": "你好",
  "welcomeUser": "欢迎，{username}！"
}
```

## 使用方法

### 在 Widget 中使用

```dart
import '../l10n/app_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Column(
      children: [
        Text(l10n.appTitle),
        Text(l10n.hello),
        Text(l10n.welcomeUser('张三')),
      ],
    );
  }
}
```

### 语言状态管理

#### LocaleStore 使用
```dart
import '../provider/locale_store.dart';

// 切换到英文
context.read<LocaleStore>().setLocale(const Locale('en'));

// 切换到中文
context.read<LocaleStore>().setLocale(const Locale('zh'));

// 快速切换语言
context.read<LocaleStore>().toggleLanguage();

// 监听语言变化
Consumer<LocaleStore>(
  builder: (context, localeStore, child) {
    return Text('当前语言: ${localeStore.locale.languageCode}');
  },
)
```

### 便捷工具类

```dart
// utils/localization_helper.dart
class LocalizationHelper {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
  
  // 常用文本快捷方法
  static String hello(BuildContext context) => of(context).hello;
  static String appTitle(BuildContext context) => of(context).appTitle;
  static String welcome(BuildContext context) => of(context).welcome;
}

// 使用示例
Text(LocalizationHelper.hello(context))
```

## 开发工作流程

### 1. 添加新文本

1. 在英文模板 `app_en.arb` 中添加新的键值对
2. 在中文翻译 `app_zh.arb` 中添加对应翻译
3. 运行 `flutter gen-l10n` 生成代码
4. 在代码中使用新的本地化文本

### 2. 生成本地化文件

```bash
# 获取依赖
flutter pub get

# 生成本地化文件
flutter gen-l10n
```

### 3. 文本参数化

#### ARB 文件定义
```json
{
  "itemCount": "You have {count} {count, plural, =0{items} =1{item} other{items}}",
  "@itemCount": {
    "description": "Display item count with pluralization",
    "placeholders": {
      "count": {
        "type": "int",
        "example": "5"
      }
    }
  },
  "lastSeen": "Last seen {date}",
  "@lastSeen": {
    "placeholders": {
      "date": {
        "type": "DateTime",
        "format": "yMd"
      }
    }
  }
}
```

#### 使用参数化文本
```dart
// 数量显示
Text(l10n.itemCount(items.length))

// 日期格式化
Text(l10n.lastSeen(DateTime.now()))
```

## 高级功能

### 1. 复数形式处理

```json
{
  "messageCount": "{count, plural, =0{No messages} =1{1 message} other{{count} messages}}",
  "@messageCount": {
    "placeholders": {
      "count": {"type": "int"}
    }
  }
}
```

### 2. 性别相关文本

```json
{
  "greeting": "{gender, select, male{Mr. {name}} female{Ms. {name}} other{Dear {name}}}",
  "@greeting": {
    "placeholders": {
      "gender": {"type": "String"},
      "name": {"type": "String"}
    }
  }
}
```

### 3. 日期和数字格式化

```dart
// 在 ARB 文件中
{
  "currentDate": "Today is {date}",
  "@currentDate": {
    "placeholders": {
      "date": {
        "type": "DateTime",
        "format": "yMMMMd"
      }
    }
  },
  "price": "Price: {amount}",
  "@price": {
    "placeholders": {
      "amount": {
        "type": "double",
        "format": "currency",
        "optionalParameters": {
          "symbol": "¥"
        }
      }
    }
  }
}
```

## 语言设置页面

### 标准语言选择页面
```dart
class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(title: Text(l10n.language)),
      body: Consumer<LocaleStore>(
        builder: (context, localeStore, child) {
          return ListView(
            children: [
              _buildLanguageTile(
                context,
                '中文',
                const Locale('zh'),
                localeStore.locale.languageCode == 'zh',
                localeStore,
              ),
              _buildLanguageTile(
                context,
                'English',
                const Locale('en'),
                localeStore.locale.languageCode == 'en',
                localeStore,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    String title,
    Locale locale,
    bool isSelected,
    LocaleStore localeStore,
  ) {
    return ListTile(
      title: Text(title),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: () => localeStore.setLocale(locale),
    );
  }
}
```

## 最佳实践

### 1. 文本键命名规范
```dart
// 好的命名
"loginButton": "Login"
"errorNetworkTimeout": "Network timeout error"
"settingsLanguageTitle": "Language Settings"

// 避免的命名
"text1": "Login"
"error": "Error"
"title": "Title"
```

### 2. 描述信息
```json
{
  "loginButton": "Login",
  "@loginButton": {
    "description": "Button text for user login action"
  }
}
```

### 3. 上下文相关的翻译
```json
{
  "buttonSave": "Save",
  "buttonSaveDocument": "Save Document",
  "buttonSaveSettings": "Save Settings"
}
```

### 4. 避免文本拼接
```dart
// 错误做法
Text('${l10n.hello} ${userName}!')

// 正确做法 - 使用参数化
Text(l10n.helloUser(userName))
```

### 5. 处理长文本
```json
{
  "privacyPolicy": "By using this app, you agree to our Privacy Policy and Terms of Service. Your data will be processed according to our privacy guidelines.",
  "@privacyPolicy": {
    "description": "Privacy policy agreement text"
  }
}
```

## 测试和验证

### 1. 语言切换测试
```dart
// 测试语言切换功能
testWidgets('Language switching test', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  // 验证默认语言
  expect(find.text('你好'), findsOneWidget);
  
  // 切换语言
  final localeStore = tester.binding.defaultBinaryMessenger;
  // ... 测试逻辑
});
```

### 2. 文本完整性检查
- 确保所有 ARB 文件包含相同的键
- 验证参数化文本的参数匹配
- 检查特殊字符和格式

### 3. UI 适配测试
- 测试不同语言下的文本长度
- 验证 UI 布局在长文本下的表现
- 检查文本截断和换行

## 添加新语言

### 1. 创建新的 ARB 文件
```bash
# 添加日语支持
touch lib/l10n/app_ja.arb
```

### 2. 添加翻译内容
```json
{
  "@@locale": "ja",
  "appTitle": "Flutter フレキシブル",
  "hello": "こんにちは",
  "welcome": "Flutter フレキシブルへようこそ"
}
```

### 3. 更新 LocaleStore
```dart
class LocaleStore extends ChangeNotifier {
  // 添加日语支持
  static const List<Locale> supportedLocales = [
    Locale('zh'),
    Locale('en'),
    Locale('ja'), // 新增
  ];
  
  void setLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) return;
    // ... 其他逻辑
  }
}
```

### 4. 重新生成文件
```bash
flutter gen-l10n
```

## 常见问题解决

### 1. 生成文件路径问题
如果生成的文件不在预期位置，检查 `l10n.yaml` 配置。

### 2. 导入路径错误
```dart
// 根据实际生成位置调整导入路径
import '../l10n/app_localizations.dart';
// 或
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

### 3. 热重载不生效
修改 ARB 文件后需要重新运行 `flutter gen-l10n` 并重启应用。

### 4. 参数类型错误
确保 ARB 文件中的参数类型与代码中使用的类型匹配。

这个指南涵盖了项目国际化的所有重要方面，确保开发团队能够正确实现和维护多语言支持。