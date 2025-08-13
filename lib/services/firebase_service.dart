import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  /// 记录非致命错误
  static Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    await FirebaseCrashlytics.instance.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  /// 记录自定义日志
  static void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  /// 设置用户标识符
  static Future<void> setUserIdentifier(String userId) async {
    await FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }

  /// 设置自定义键值对
  static Future<void> setCustomKey(String key, Object value) async {
    await FirebaseCrashlytics.instance.setCustomKey(key, value);
  }

  /// 强制发送崩溃报告（仅用于测试）
  static void crash() {
    if (kDebugMode) {
      FirebaseCrashlytics.instance.crash();
    }
  }

  /// 检查是否启用了崩溃收集
  static bool isCrashlyticsCollectionEnabled() {
    return FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
  }

  /// 启用或禁用崩溃收集
  static Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled);
  }

  /// 发送未捕获的异常
  static Future<void> recordFlutterError(
      FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  }
}
