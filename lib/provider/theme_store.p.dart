import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/themes/index_theme.dart';

enum AppThemeMode {
  lightBlue,
  dark,
  blue,
}

// Provider状态管理使用
class ThemeStore with ChangeNotifier {
  static const String _themeKey = 'app_theme_mode';
  AppThemeMode _currentTheme = AppThemeMode.lightBlue;
  ThemeData _themeData = themeLightBlue;

  ThemeStore() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    _currentTheme = AppThemeMode.values[themeIndex];
    _updateThemeData();
    notifyListeners();
  }

  void _updateThemeData() {
    switch (_currentTheme) {
      case AppThemeMode.lightBlue:
        _themeData = themeLightBlue;
        break;
      case AppThemeMode.dark:
        _themeData = themeDark;
        break;
      case AppThemeMode.blue:
        _themeData = themeBlue;
        break;
    }
  }

  Future<void> setThemeMode(AppThemeMode themeMode) async {
    _currentTheme = themeMode;
    _updateThemeData();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, themeMode.index);
    notifyListeners();
  }

  // 保持向后兼容性
  void setTheme(ThemeData themeName) {
    _themeData = themeName;
    notifyListeners();
  }

  AppThemeMode get currentTheme => _currentTheme;
  ThemeData get getTheme => _themeData;
}
