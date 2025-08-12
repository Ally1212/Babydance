import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadUserBox extends StatefulWidget {
  @override
  State<HeadUserBox> createState() => _HeadUserBoxState();
}

class _HeadUserBoxState extends State<HeadUserBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        btnWidget(
          title: "用户信息",
          onTap: () {
            // 可以在这里添加其他功能
          },
        ),
      ],
    );
  }

  Widget baseBox({Widget? child}) {
    const double interval = 20;
    return Container(
      alignment: Alignment.center,
      height: 130,
      margin: const EdgeInsets.fromLTRB(interval, 0, interval, 0),
      child: child,
    );
  }

  Widget btnWidget({required String title, VoidCallback? onTap}) {
    return baseBox(
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 30.sp), // 调整：33.sp → 30.sp
        ),
      ),
    );
  }
}
