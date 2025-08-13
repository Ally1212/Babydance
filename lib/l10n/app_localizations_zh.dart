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
}
