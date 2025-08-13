import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class LocalizationHelper {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  // 便捷方法获取常用文本
  static String hello(BuildContext context) => of(context).hello;
  static String welcome(BuildContext context) => of(context).welcome;
  static String settings(BuildContext context) => of(context).settings;
  static String language(BuildContext context) => of(context).language;
  static String save(BuildContext context) => of(context).save;
  static String cancel(BuildContext context) => of(context).cancel;
  static String confirm(BuildContext context) => of(context).confirm;
  static String loading(BuildContext context) => of(context).loading;
  static String error(BuildContext context) => of(context).error;
  static String retry(BuildContext context) => of(context).retry;
}
