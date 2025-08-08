import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateHeader extends StatelessWidget {
  UpdateHeader({this.version});

  /// 最新版本号
  final String? version;
  final String headerImg = 'asset/images/updateVersion/header/up_header.png';
  final Color strColor = Colors.white; // 文字颜色
  final double boxHeight = 270.w; // 盒子高度 调整：290.w → 270.w

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: boxHeight,
      child: Stack(
        children: <Widget>[
          // 背景图
          Image(
            width: double.infinity,
            height: boxHeight,
            image: AssetImage(headerImg),
            fit: BoxFit.fill,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
              children: <Widget>[
                Text(
                  '发现新版本',
                  style: TextStyle(
                    color: strColor,
                    fontSize: 38.sp, // 调整：40.sp → 38.sp
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 3, top: 6),
                  child: Text(
                    version != null ? 'v$version' : '', // 最新版本号
                    style: TextStyle(
                      color: strColor,
                      fontSize: 28.sp, // 调整：30.sp → 28.sp
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
