import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as p; // Import path package

class SupabaseStorageService {
  static const String _bucketName = 'xxxxxx'; // 替换为你的存储桶名称

  final SupabaseClient _supabase;

  SupabaseStorageService() : _supabase = Supabase.instance.client;

  /// 上传文件到存储桶
  /// [file] 要上传的文件
  /// [destinationPath] 可选的目标路径，如果不提供则使用文件名
  /// [contentType] 文件MIME类型，如果未提供则根据文件扩展名自动推断
  Future<String> uploadFile({
    required File file,
    String? destinationPath,
    String? contentType,
  }) async {
    // --- 生成唯一文件名 ---
    final String originalFileName = p.basename(file.path);
    final String fileExtension = p.extension(originalFileName);
    final String fileNameWithoutExt = p.basenameWithoutExtension(
      originalFileName,
    );
    // 组合新的唯一文件名：原始文件名 + 时间戳 + 扩展名
    final String uniqueFileName =
        '${fileNameWithoutExt}_${DateTime.now().millisecondsSinceEpoch}$fileExtension';

    // 如果用户提供了目标路径，则将唯一文件名附加到该路径下
    final String targetPath = destinationPath != null
        ? p.join(destinationPath, uniqueFileName)
        : uniqueFileName;
    // --- 结束 ---

    try {
      // 执行上传
      final fileBytes = await file.readAsBytes();
      final fileContentType =
          contentType ?? _getContentType(targetPath); // 使用helper方法

      await Supabase.instance.client.storage.from(_bucketName).uploadBinary(
            targetPath,
            fileBytes,
            fileOptions: FileOptions(
              contentType: fileContentType,
              upsert: false, // 确保如果并发场景下文件已存在则不覆盖 (虽然我们已经检查了)
            ),
          );

      return getPublicUrl(targetPath);
    } catch (e) {
      // 细化错误处理，特别是 StorageError
      if (e is StorageException) {
        // 打印详细的存储错误信息，这对于调试权限问题至关重要
      }
      throw Exception('文件上传失败: $e');
    }
  }

  /// 上传Base64编码的文件到存储桶
  /// [base64String] 要上传的Base64编码的字符串
  /// [fileName] 原始文件名，用于提取扩展名和基本名称
  /// [destinationPath] 可选的目标路径
  Future<String> uploadBase64File({
    required String base64String,
    required String fileName,
    String? destinationPath,
  }) async {
    // --- 解码Base64字符串 ---
    final Uint8List fileBytes;
    try {
      // 移除Base64字符串可能包含的MIME类型前缀 (e.g., "data:image/png;base64,")
      final pureBase64 = base64String.split(',').last;
      fileBytes = base64.decode(pureBase64);
    } catch (e) {
      throw Exception('Base64解码失败: $e');
    }

    // --- 生成唯一文件名 ---
    final String originalFileName = fileName;
    final String fileExtension = p.extension(originalFileName);
    final String fileNameWithoutExt = p.basenameWithoutExtension(
      originalFileName,
    );
    final String uniqueFileName =
        '${fileNameWithoutExt}_${DateTime.now().millisecondsSinceEpoch}$fileExtension';

    final String targetPath = destinationPath != null
        ? p.join(destinationPath, uniqueFileName)
        : uniqueFileName;
    // --- 结束 ---

    try {
      // 执行上传
      final fileContentType = _getContentType(targetPath);

      await Supabase.instance.client.storage.from(_bucketName).uploadBinary(
            targetPath,
            fileBytes,
            fileOptions: FileOptions(
              contentType: fileContentType,
              upsert: false,
            ),
          );

      return getPublicUrl(targetPath);
    } catch (e) {
      if (e is StorageException) {}
      throw Exception('文件上传失败: $e');
    }
  }

  /// 根据文件扩展名获取contentType
  String _getContentType(String path) {
    final ext = p.extension(path).toLowerCase(); // 使用 path.extension
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.pdf':
        return 'application/pdf';
      case '.mp4':
        return 'video/mp4';
      // You can add more cases for other file types as needed
      default:
        // 如果扩展名为空或未知，则使用通用二进制流
        return 'application/octet-stream';
    }
  }

  /// 获取文件公开URL
  String getPublicUrl(String filePath) {
    return _supabase.storage.from(_bucketName).getPublicUrl(filePath);
  }

  /// 下载文件
  Future<Uint8List> downloadFile(String filePath) async {
    try {
      return await _supabase.storage.from(_bucketName).download(filePath);
    } catch (e) {
      throw Exception('文件下载失败: $e');
    }
  }

  /// 删除文件
  Future<void> deleteFile(String filePath) async {
    try {
      await _supabase.storage.from(_bucketName).remove([filePath]);
    } catch (e) {
      throw Exception('文件删除失败: $e');
    }
  }

  /// 列出存储桶中的文件
  Future<List<FileObject>> listFiles({
    String? path,
    int limit = 100,
    int offset = 0,
    String sortBy = 'name',
  }) async {
    try {
      final result = await _supabase.storage.from(_bucketName).list(
            path: path,
            searchOptions: SearchOptions(
              limit: limit,
              offset: offset,
              sortBy: SortBy(column: sortBy, order: 'asc'),
            ),
          );
      return result;
    } catch (e) {
      throw Exception('获取文件列表失败: $e');
    }
  }
}
