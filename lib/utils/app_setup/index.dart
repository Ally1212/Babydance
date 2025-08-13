// 初始化第三方插件
import '../../config/app_env.dart';
import '../tool/sp_util.dart';
import 'ana_page_loop_init.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import '../../firebase_options.dart';

/// 应用启动时的一次性初始化（异步）
Future<void> appSetupInitAsync() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
