import 'package:flutter/material.dart';
import '../utils/tool/sp_util.dart';

class LocaleStore extends ChangeNotifier {
  static const String _localeKey = 'app_locale';
  Locale _locale = const Locale('zh');

  Locale get locale => _locale;

  LocaleStore() {
    _loadLocale();
  }

  void setLocale(Locale locale) async {
    if (_locale == locale) return;

    _locale = locale;
    notifyListeners();

    // 使用封装的本地存储工具保存语言设置
    final spUtil = await SpUtil.getInstance();
    await spUtil.setData(_localeKey, locale.languageCode);
  }

  void _loadLocale() async {
    // 使用封装的本地存储工具加载语言设置
    final spUtil = await SpUtil.getInstance();
    final localeCode = await spUtil.getData<String>(_localeKey, defValue: 'zh');
    _locale = Locale(localeCode);
    notifyListeners();
  }

  // 切换语言的便捷方法
  void toggleLanguage() {
    if (_locale.languageCode == 'zh') {
      setLocale(const Locale('en'));
    } else {
      setLocale(const Locale('zh'));
    }
  }
}
