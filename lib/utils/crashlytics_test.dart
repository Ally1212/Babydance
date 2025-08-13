import '../services/firebase_service.dart';

class CrashlyticsTest {
  /// 测试记录非致命错误
  static Future<void> testRecordError() async {
    try {
      throw Exception('这是一个测试异常');
    } catch (error, stackTrace) {
      await FirebaseService.recordError(
        error,
        stackTrace,
        reason: '测试Crashlytics错误记录功能',
        fatal: false,
      );
    }
  }

  /// 测试记录日志
  static void testLog() {
    FirebaseService.log('测试Crashlytics日志记录功能');
  }

  /// 测试设置用户信息
  static Future<void> testSetUserInfo() async {
    await FirebaseService.setUserIdentifier('test_user_123');
    await FirebaseService.setCustomKey('user_level', 'premium');
    await FirebaseService.setCustomKey('app_version', '1.0.0');
  }

  /// 测试崩溃（仅在调试模式下）
  static void testCrash() {
    FirebaseService.crash();
  }

  /// 检查Crashlytics是否启用
  static bool checkCrashlyticsEnabled() {
    return FirebaseService.isCrashlyticsCollectionEnabled();
  }
}
