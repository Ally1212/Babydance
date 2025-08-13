import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// 一个专门用于文件下载的辅助类
class FileDownloader {
  /// 下载一个文件并将其保存到应用的本地目录中。
  ///
  /// [fileUrl] - 要下载的文件的在线 URL。
  /// [savePath] - (可选) 指定的本地保存路径。如果未提供，将保存到临时目录。
  /// 返回下载后文件的本地路径。如果下载失败，则抛出异常。
  static Future<String> downloadFileToLocalPath(
    String fileUrl, [
    String? savePath,
  ]) async {
    final Dio dio = Dio();

    try {
      String localPath;
      if (savePath == null) {
        final Directory tempDir = await getTemporaryDirectory();
        String fileName = p.basename(Uri.parse(fileUrl).path);

        // 如果文件名没有扩展名，则尝试从 Content-Type 推断
        if (!p.extension(fileName).contains(
              RegExp(
                r'\.(png|jpg|jpeg|gif|mp4|mov|webp|heic)$',
                caseSensitive: false,
              ),
            )) {
          try {
            final response = await dio.head(fileUrl);
            final contentType = response.headers.value('content-type');
            if (contentType != null) {
              final extension = extensionFromMime(contentType);
              fileName = '$fileName.$extension';
            }
          } catch (e) {
            if (kDebugMode) {
              print('无法获取 Content-Type，将使用默认扩展名: $e');
            }
            // 回退到默认扩展名
            fileName = '$fileName.jpg';
          }
        }

        // 如果文件名仍然无效，则提供一个默认名称
        if (fileName.isEmpty || fileName == '.') {
          fileName = 'downloaded_file.jpg';
        }

        localPath = p.join(tempDir.path, fileName);
      } else {
        localPath = savePath;
        final File file = File(localPath);
        final Directory dir = file.parent;
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
      }

      if (kDebugMode) {
        print('开始下载文件: $fileUrl');
        print('将保存到本地: $localPath');
      }
      await dio.download(fileUrl, localPath);

      final file = File(localPath);
      if (await file.exists()) {
        if (kDebugMode) {
          print('文件下载成功: $localPath');
        }
        return localPath;
      } else {
        throw Exception('文件下载后未找到');
      }
    } catch (e) {
      if (kDebugMode) {
        print('下载文件时发生错误: $e');
      }
      rethrow;
    }
  }
}

/// 根据 MIME 类型返回常见文件扩展名
String extensionFromMime(String mimeType) {
  switch (mimeType.toLowerCase()) {
    case 'image/jpeg':
    case 'image/jpg':
      return 'jpg';
    case 'image/png':
      return 'png';
    case 'image/gif':
      return 'gif';
    case 'image/webp':
      return 'webp';
    case 'image/heic':
      return 'heic';
    case 'video/mp4':
      return 'mp4';
    case 'video/quicktime':
      return 'mov';
    default:
      return 'jpg'; // 默认返回 jpg
  }
}
