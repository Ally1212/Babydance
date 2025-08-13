// 初始化第三方插件
import '../../config/app_env.dart';
import '../tool/sp_util.dart';
import 'ana_page_loop_init.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import '../../firebase_options.dart';

/// 应用启动时的一次性初始化（异步）
Future<void> appSetupInitAsync() async {
  // await Supabase.initialize(
  //   url: 'YOUR_SUPABASE_URL',
  //   anonKey: 'YOUR_SUPABASE_ANON_KEY',
  // );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 打印日志以确认 Firebase 初始化成功
  if (kDebugMode) {
    print('✅ Firebase initialized successfully.');
  }

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

/// 应用构建时的同步初始化
void appSetupInit() {
  appEnv.init(); // 初始环境
  anaPageLoopInit();
  SpUtil.getInstance(); // 本地缓存初始化
}
