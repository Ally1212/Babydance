#!/usr/bin/env dart

/// 尺寸调整验证脚本
/// 检查项目中的尺寸使用情况，确保调整符合402x874基准

import 'dart:io';

void main() {
  print('🔍 Flutter项目尺寸调整验证工具');
  print('基准尺寸: 402x874');
  print('=' * 50);

  final verifier = SizeVerifier();
  verifier.verifyAllFiles();
}

class SizeVerifier {
  // 推荐的尺寸范围
  final Map<String, List<double>> recommendedRanges = {
    'fontSize': [16.0, 60.0], // 字体大小推荐范围
    'containerWidth': [20.0, 400.0], // 容器宽度推荐范围
    'containerHeight': [20.0, 800.0], // 容器高度推荐范围
    'iconSize': [16.0, 50.0], // 图标大小推荐范围
  };

  void verifyAllFiles() {
    final libDir = Directory('lib');
    if (!libDir.existsSync()) {
      print('❌ 错误: 未找到lib目录');
      return;
    }

    final dartFiles = _findDartFiles(libDir);
    print('📁 检查 ${dartFiles.length} 个Dart文件\\n');

    int totalIssues = 0;
    final Map<String, int> sizeUsage = {};

    for (final file in dartFiles) {
      final issues = _verifyFile(file, sizeUsage);
      totalIssues += issues;
    }

    _printSummary(totalIssues, sizeUsage);
  }

  List<File> _findDartFiles(Directory dir) {
    final files = <File>[];

    for (final entity in dir.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        if (!entity.path.contains('.g.dart') &&
            !entity.path.contains('.freezed.dart') &&
            !entity.path.contains('test/')) {
          files.add(entity);
        }
      }
    }

    return files;
  }

  int _verifyFile(File file, Map<String, int> sizeUsage) {
    try {
      final content = file.readAsStringSync();
      int issues = 0;

      // 检查字体大小
      final fontSizeRegex = RegExp(r'fontSize:\\s*(\\d+(?:\\.\\d+)?)\\.sp');
      final fontMatches = fontSizeRegex.allMatches(content);

      for (final match in fontMatches) {
        final size = double.parse(match.group(1)!);
        final sizeKey = '${size.toInt()}.sp';
        sizeUsage[sizeKey] = (sizeUsage[sizeKey] ?? 0) + 1;

        if (size < recommendedRanges['fontSize']![0] ||
            size > recommendedRanges['fontSize']![1]) {
          _logIssue(file.path, '字体大小', sizeKey, '可能过大或过小');
          issues++;
        }
      }

      // 检查容器尺寸
      final containerRegex =
          RegExp(r'(width|height):\\s*(\\d+(?:\\.\\d+)?)\\.w');
      final containerMatches = containerRegex.allMatches(content);

      for (final match in containerMatches) {
        final type = match.group(1)!;
        final size = double.parse(match.group(2)!);
        final sizeKey = '${size.toInt()}.w';
        sizeUsage[sizeKey] = (sizeUsage[sizeKey] ?? 0) + 1;

        final rangeKey = type == 'width' ? 'containerWidth' : 'containerHeight';
        if (size < recommendedRanges[rangeKey]![0] ||
            size > recommendedRanges[rangeKey]![1]) {
          _logIssue(file.path, '容器${type == 'width' ? '宽度' : '高度'}', sizeKey,
              '可能不适合402x874基准');
          issues++;
        }
      }

      // 检查图标尺寸
      final iconRegex = RegExp(r'size:\\s*(\\d+(?:\\.\\d+)?)\\.sp');
      final iconMatches = iconRegex.allMatches(content);

      for (final match in iconMatches) {
        final size = double.parse(match.group(1)!);
        final sizeKey = '${size.toInt()}.sp';

        if (size < recommendedRanges['iconSize']![0] ||
            size > recommendedRanges['iconSize']![1]) {
          _logIssue(file.path, '图标大小', sizeKey, '可能过大或过小');
          issues++;
        }
      }

      return issues;
    } catch (e) {
      print('❌ 检查文件失败: ${file.path}');
      return 0;
    }
  }

  void _logIssue(String filePath, String type, String value, String reason) {
    final relativePath = filePath.replaceFirst(RegExp(r'^.*lib/'), 'lib/');
    print('⚠️  $relativePath');
    print('   $type: $value - $reason');
  }

  void _printSummary(int totalIssues, Map<String, int> sizeUsage) {
    print('\\n📊 检查结果汇总');
    print('=' * 30);

    if (totalIssues == 0) {
      print('✅ 太棒了！没有发现尺寸问题');
    } else {
      print('⚠️  发现 $totalIssues 个潜在问题');
    }

    print('\\n📏 尺寸使用统计:');
    final sortedSizes = sizeUsage.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    for (final entry in sortedSizes.take(10)) {
      print('   ${entry.key}: ${entry.value}次');
    }

    print('\\n💡 建议:');
    print('   • 字体大小建议范围: 16.sp - 60.sp');
    print('   • 容器宽度建议范围: 20.w - 400.w');
    print('   • 容器高度建议范围: 20.w - 800.w');
    print('   • 图标大小建议范围: 16.sp - 50.sp');
    print('   • 基准屏幕: 402x874');
  }
}
