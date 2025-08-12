import 'package:flutter/material.dart';
import 'components/set_theme_demo.dart';
import 'components/head_userbox.dart';
import '../../../routes/route_name.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPersonal页面'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          HeadUserBox(),
          SetThemeDemo(),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.versionTest);
              },
              child: Text('版本更新测试'),
            ),
          ),
        ],
      ),
    );
  }
}
