// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Flutter 灵活框架';

  @override
  String get hello => '你好';

  @override
  String get welcome => '欢迎使用 Flutter 灵活框架';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get loading => '加载中...';

  @override
  String get error => '错误';

  @override
  String get retry => '重试';

  @override
  String get home => '首页';

  @override
  String get myPersonal => '我的';

  @override
  String get userInfo => '用户信息';

  @override
  String get themeSwitch => '全局主题色切换';

  @override
  String get lightBlueTheme => '天蓝色主题';

  @override
  String get darkMode => '暗模式';

  @override
  String get grayModeOn => '灰度模式--开启';

  @override
  String get grayModeOff => '灰度模式--关闭';

  @override
  String get errorPageTitle => '错误';

  @override
  String get undefinedRoute => '错误：未定义的路由';

  @override
  String adPageCountdown(int seconds) {
    return '广告页，$seconds 秒后跳转到主页';
  }

  @override
  String get skip => '跳过';

  @override
  String get guidePage => '引导页～';

  @override
  String stateManagementValue(int value) {
    return '状态管理值：$value';
  }

  @override
  String get increment => '加+';

  @override
  String get decrement => '减-';

  @override
  String currentLanguage(String language) {
    return '当前语言：$language';
  }

  @override
  String get settingsPage => '设置页面';

  @override
  String get settingsContent => '这里是设置页面的内容';

  @override
  String get appSettings => '应用设置和偏好';

  @override
  String get generalSettings => '通用设置';

  @override
  String get languageSettings => '语言设置';

  @override
  String get languageSettingsDesc => '选择应用语言';

  @override
  String get notificationSettings => '通知设置';

  @override
  String get notificationSettingsDesc => '管理通知偏好';

  @override
  String get privacySettings => '隐私与安全';

  @override
  String get privacySettingsDesc => '隐私设置和安全选项';

  @override
  String get appearanceSettings => '外观设置';

  @override
  String get themeSettings => '主题设置';

  @override
  String get themeSettingsDesc => '选择应用主题';

  @override
  String get fontSettings => '字体大小';

  @override
  String get fontSettingsDesc => '调整文字显示大小';

  @override
  String get aboutSection => '关于';

  @override
  String get aboutApp => '关于应用';

  @override
  String get aboutAppDesc => '版本信息和开发者信息';

  @override
  String get helpFeedback => '帮助与反馈';

  @override
  String get helpFeedbackDesc => '获取帮助或提供反馈';

  @override
  String get featureInDevelopment => '功能开发中';

  @override
  String get notificationFeatureInDev => '通知设置功能开发中';

  @override
  String get privacyFeatureInDev => '隐私设置功能开发中';

  @override
  String get themeFeatureInDev => '主题设置功能开发中';

  @override
  String get fontFeatureInDev => '字体设置功能开发中';

  @override
  String get helpFeatureInDev => '帮助功能开发中';

  @override
  String get aboutAppDescription => '这是一个基于Flutter开发的灵活应用框架，提供了丰富的功能和良好的用户体验。';
}
