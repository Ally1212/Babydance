import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../l10n/app_localizations.dart';
import 'provider/counterStore.p.dart';
import '../../../provider/locale_store.dart';

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

    return ListView(
      children: List.generate(1, (index) {
        return Column(
          children: <Widget>[
            SizedBox(height: 50.sp),
            Text(
              localizations.welcome,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.sp),
            Text(
              '${localizations.hello}!',
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(height: 10.sp),
            Text(
              localizations
                  .stateManagementValue(context.watch<CounterStore>().value),
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(height: 20.sp),
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
            SizedBox(height: 30.sp),
          ],
        );
      }),
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
