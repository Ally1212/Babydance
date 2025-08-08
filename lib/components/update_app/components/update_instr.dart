import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateInstr extends StatelessWidget {
  const UpdateInstr({@required this.data});
  final List<String>? data;

  @override
  Widget build(BuildContext context) {
    int len = data?.length ?? 0;
    return Container(
      height: 300.w, // 调整：320.w → 300.w
      padding: EdgeInsets.only(left: 20, right: 20, top: 1.w),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          for (var i = 0; i < len; i++)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                '${i + 1}、${data![i]}',
                style: TextStyle(fontSize: 26.sp), // 调整：28.sp → 26.sp
              ),
            ),
        ],
      ),
    );
  }
}
