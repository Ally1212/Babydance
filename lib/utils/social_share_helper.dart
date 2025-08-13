import 'dart:convert';
import 'dart:io';
import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'file_downloader.dart';

/// 封装社交分享逻辑的辅助类
class SocialShareHelper {
  static final AppinioSocialShare _socialShare = AppinioSocialShare();

  /// 根据平台分享内容
  ///
  /// [message] - 分享的文本信息.
  /// [imageUrl] - (可选) 在线图片的 URL.
  static Future<void> shareTo(
    String platform,
    String message,
    String? imagePathOrUrl,
  ) async {
    String? localPath;

    try {
      // 因为 imagePathOrUrl 总是一个在线 URL，我们总是先下载它
      if (imagePathOrUrl != null && imagePathOrUrl.isNotEmpty) {
        final directory = await getTemporaryDirectory();
        final fileName = '${md5.convert(utf8.encode(imagePathOrUrl))}.jpg';
        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);

        if (await file.exists()) {
          localPath = filePath;
        } else {
          localPath = await FileDownloader.downloadFileToLocalPath(
            imagePathOrUrl,
            filePath,
          );
        }
      }

      switch (platform) {
        case 'instagram':
          await _socialShare.iOS.shareToInstagramFeed(localPath!);
          break;
        case 'twitter':
          await _socialShare.iOS.shareToTwitter(message, localPath);
          break;
        case 'facebook':
          // Facebook 分享需要一个 List<String>
          await _socialShare.iOS.shareToFacebook(message, [localPath!]);
          break;
        case 'system':
          // whatsapp分享图片时, appinio_social_share插件会使用系统分享表单
          // 为了能同时传递图片和文字, 我们统一使用shareToSystem方法
          await _socialShare.iOS.shareToSystem(
            message,
            filePaths: localPath != null ? [localPath] : [],
          );
          break;
      }
    } catch (e) {
      if (kDebugMode) {
        print('分享到 $platform 时发生错误: $e');
      }
      Fluttertoast.showToast(msg: "分享失败，请稍后再试。");
    }
  }
}
