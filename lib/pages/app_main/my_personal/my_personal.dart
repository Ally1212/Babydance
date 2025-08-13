import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'components/set_theme_demo.dart';
import 'components/head_userbox.dart';

class MyPersonal extends StatefulWidget {
  @override
  State<MyPersonal> createState() => _MyPersonalState();
}

class _MyPersonalState extends State<MyPersonal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.myPersonal),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [HeadUserBox(), SetThemeDemo()]),
    );
  }
}
