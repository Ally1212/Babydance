import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/theme_store.p.dart';
import '../../../../constants/themes/index_theme.dart';
import '../../../../provider/global.p.dart';
import '../../../../l10n/app_localizations.dart';

class SetThemeDemo extends StatefulWidget {
  @override
  State<SetThemeDemo> createState() => _SetThemeDemoState();
}

class _SetThemeDemoState extends State<SetThemeDemo> {
  late ThemeStore _theme;
  late GlobalStore appPageStore;

  @override
  Widget build(BuildContext context) {
    _theme = Provider.of<ThemeStore>(context);
    appPageStore = Provider.of<GlobalStore>(context);
    final localizations = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: <Widget>[
            Text(localizations.themeSwitch,
                style: const TextStyle(fontSize: 30)),
            btnWidget(
                localizations.lightBlueTheme, themeLightBlue, Colors.lightBlue),
            btnWidget(localizations.darkMode, ThemeData.dark(),
                ThemeData.dark().colorScheme.surface),
            grayBtn(),
          ],
        ),
      ],
    );
  }

  /// 灰度按钮
  Widget grayBtn() {
    final localizations = AppLocalizations.of(context)!;

    return ElevatedButton(
      child: Text(
        appPageStore.getGrayTheme
            ? localizations.grayModeOn
            : localizations.grayModeOff,
        style: const TextStyle(fontSize: 22),
      ),
      onPressed: () {
        appPageStore.setGrayTheme(!appPageStore.getGrayTheme);
      },
    );
  }

  Widget btnWidget(String title, ThemeData themeData, Color color) {
    return ElevatedButton(
      onPressed: () {
        _theme.setTheme(themeData);
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, color: Colors.white70),
      ),
    );
  }
}
