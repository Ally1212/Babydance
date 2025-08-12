import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
    return ListView(
      children: List.generate(1, (index) {
        return Column(
          children: <Widget>[
            SizedBox(height: 50.sp),
            Text('状态管理值：${context.watch<CounterStore>().value}'),
            _button(
              '加+',
              onPressed: () {
                _counter.increment();
              },
            ),
            _button(
              '减-',
              onPressed: () {
                _counter.decrement();
              },
            ),
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
