import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../l10n/app_localizations.dart';
import 'provider/counterStore.p.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.params});
  final dynamic params;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late CounterStore _counter;
  FocusNode blankNode = FocusNode(); // 响应空白处的焦点的Node

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _counter = Provider.of<CounterStore>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(blankNode);
        },
        child: contextWidget(),
      ),
    );
  }

  Widget contextWidget() {
    final localizations = AppLocalizations.of(context)!;
    final services = [
      "Firebase 统计服务",
      "崩溃收集服务",
      "OneSignal 通知服务",
      "Supabase 集成 - 认证服务 - S3 存储服务",
      "App 社交分享工具",
      "主题切换服务",
      "路由管理",
      "国际化",
      "协议文件"
    ];

    return ListView(
      children: <Widget>[
        SizedBox(height: 20.sp),
        Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  localizations.welcome,
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.sp),
                Text(
                  '${localizations.hello}!',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                ),
                SizedBox(height: 10.sp),
                Text(
                  localizations.stateManagementValue(
                      context.watch<CounterStore>().value),
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _button(
              localizations.increment,
              onPressed: () {
                _counter.increment();
              },
            ),
            _button(
              localizations.decrement,
              onPressed: () {
                _counter.decrement();
              },
            ),
          ],
        ),
        SizedBox(height: 30.sp),
        Padding(
          padding: EdgeInsets.all(16.sp),
          child: Text(
            "内置服务",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: services.map((service) {
              return Card(
                elevation: 3.0,
                color: Colors.blue.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified_user_outlined,
                          size: 22.0, color: Colors.blueAccent),
                      const SizedBox(width: 10.0),
                      Flexible(
                        child: Text(
                          service,
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.black87),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20.0)
      ],
    );
  }

  Widget _button(String text, {VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 21.sp), // 调整：22.sp → 21.sp
        ),
      ),
    );
  }
}
