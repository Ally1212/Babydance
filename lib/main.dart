import 'package:flutter/material.dart';
import 'package:flutter_flexible/components/layouts/basic_layout.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'routes/generate_route.dart' show generateRoute;
import 'routes/routes_data.dart'; // 路由配置
import 'providers_config.dart' show providersConfig; // providers配置文件
import 'provider/theme_store.p.dart'; // 全局主题
import 'provider/locale_store.dart'; // 语言管理
import 'config/common_config.dart' show commonConfig;
import 'package:ana_page_loop/ana_page_loop.dart' show anaAllObs;
import 'utils/app_setup/index.dart' show appSetupInit, appSetupInitAsync;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 异步初始化（Firebase等）
  await appSetupInitAsync();

  runApp(
    MultiProvider(
      providers: providersConfig,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    appSetupInit(); // 同步初始化

    return Consumer2<ThemeStore, LocaleStore>(
      builder: (context, themeStore, localeStore, child) {
        return BasicLayout(
          child: MaterialApp(
            navigatorKey: commonConfig.getGlobalKey,
            showPerformanceOverlay: false,
            locale: localeStore.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: themeStore.getTheme,
            initialRoute: initialRoute,
            onGenerateRoute: generateRoute, // 路由处理
            debugShowCheckedModeBanner: false,
            navigatorObservers: [...anaAllObs()],
          ),
        );
      },
    );
  }
}
