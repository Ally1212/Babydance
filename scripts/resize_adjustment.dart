#!/usr/bin/env dart

/// Flutter项目尺寸自动调整脚本
/// 基于402x874基准尺寸的优化调整
///
/// 使用方法：
/// dart scripts/resize_adjustment.dart [--dry-run] [--conservative]
///
/// 参数说明：
/// --dry-run: 仅显示将要进行的更改，不实际修改文件
/// --conservative: 使用保守的调整方案（较小的调整幅度）

import 'dart:io';
import 'dart:convert';

void main(List<String> arguments) {
  final bool dryRun = arguments.contains('--dry-run');
  final bool conservative = arguments.contains('--conservative');

  print('🎯 Flutter项目尺寸调整工具');
  print('基准尺寸: 402x874');
  print('调整模式: ${conservative ? "保守调整" : "全面优化"}');
  print('执行模式: ${dryRun ? "预览模式" : "实际调整"}');
  print('=' * 50);

  final adjuster = SizeAdjuster(dryRun: dryRun, conservative: conservative);
  adjuster.adjustAllFiles();
}

class SizeAdjuster {
  final bool dryRun;
  final bool conservative;

  // 调整映射表
  late Map<String, String> fontSizeMap;
  late Map<String, String> containerSizeMap;
  late Map<String, String> iconSizeMap;

  SizeAdjuster({required this.dryRun, required this.conservative}) {
    _initializeMaps();
  }

  void _initializeMaps() {
    if (conservative) {
      // 保守调整方案
      fontSizeMap = {
        '64.sp': '58.sp',
        '40.sp': '38.sp',
        '34.sp': '32.sp',
        '32.sp': '30.sp',
        '30.sp': '28.sp',
        '28.sp': '26.sp',
        '26.sp': '24.sp',
        '22.sp': '21.sp',
        '18.sp': '17.sp',
      };

      containerSizeMap = {
        '760.w': '720.w',
        '550.w': '500.w',
        '360.w': '340.w',
        '320.w': '300.w',
        '300.w': '280.w',
        '290.w': '270.w',
        '140.w': '130.w',
        '128.w': '115.w',
        '76.w': '68.w',
        '64.w': '58.w',
        '48.w': '44.w',
        '46.w': '42.w',
        '20.w': '18.w',
      };

      iconSizeMap = {
        '44.sp': '40.sp',
        '36.sp': '34.sp',
      };
    } else {
      // 全面优化方案
      fontSizeMap = {
        '64.sp': '56.sp',
        '40.sp': '36.sp',
        '34.sp': '30.sp',
        '32.sp': '28.sp',
        '30.sp': '26.sp',
        '28.sp': '24.sp',
        '26.sp': '22.sp',
        '22.sp': '20.sp',
        '18.sp': '16.sp',
      };

      containerSizeMap = {
        '760.w': '680.w',
        '550.w': '480.w',
        '360.w': '320.w',
        '320.w': '280.w',
        '300.w': '260.w',
        '290.w': '250.w',
        '140.w': '120.w',
        '128.w': '110.w',
        '76.w': '65.w',
        '64.w': '55.w',
        '48.w': '40.w',
        '46.w': '40.w',
        '20.w': '18.w',
      };

      iconSizeMap = {
        '44.sp': '38.sp',
        '36.sp': '32.sp',
      };
    }
  }

  void adjustAllFiles() {
    final libDir = Directory('lib');
    if (!libDir.existsSync()) {
      print('❌ 错误: 未找到lib目录，请在Flutter项目根目录运行此脚本');
      return;
    }

    final dartFiles = _findDartFiles(libDir);
    print('📁 找到 ${dartFiles.length} 个Dart文件');

    int totalChanges = 0;

    for (final file in dartFiles) {
      final changes = _adjustFile(file);
      totalChanges += changes;
    }

    print('\\n✅ 调整完成！');
    print('📊 总计处理: ${dartFiles.length} 个文件');
    print('🔧 总计调整: $totalChanges 处尺寸');

    if (dryRun) {
      print('\\n💡 这是预览模式，没有实际修改文件');
      print('   要应用更改，请运行: dart scripts/resize_adjustment.dart');
    } else {
      print('\\n🎉 所有调整已应用到项目中');
      print('   建议运行测试确保一切正常');
    }
  }

  List<File> _findDartFiles(Directory dir) {
    final files = <File>[];

    for (final entity in dir.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        // 排除生成的文件和测试文件
        if (!entity.path.contains('.g.dart') &&
            !entity.path.contains('.freezed.dart') &&
            !entity.path.contains('test/')) {
          files.add(entity);
        }
      }
    }

    return files;
  }

  int _adjustFile(File file) {
    try {
      final content = file.readAsStringSync();
      String newContent = content;
      int changes = 0;

      // 调整字体大小
      for (final entry in fontSizeMap.entries) {
        final oldValue = entry.key;
        final newValue = entry.value;
        final regex = RegExp(r'\\b' + RegExp.escape(oldValue) + r'\\b');
        final matches = regex.allMatches(newContent);

        if (matches.isNotEmpty) {
          newContent = newContent.replaceAll(regex, newValue);
          changes += matches.length;
          _logChange(file.path, '字体大小', oldValue, newValue, matches.length);
        }
      }

      // 调整容器尺寸
      for (final entry in containerSizeMap.entries) {
        final oldValue = entry.key;
        final newValue = entry.value;
        final regex = RegExp(r'\\b' + RegExp.escape(oldValue) + r'\\b');
        final matches = regex.allMatches(newContent);

        if (matches.isNotEmpty) {
          newContent = newContent.replaceAll(regex, newValue);
          changes += matches.length;
          _logChange(file.path, '容器尺寸', oldValue, newValue, matches.length);
        }
      }

      // 调整图标尺寸
      for (final entry in iconSizeMap.entries) {
        final oldValue = entry.key;
        final newValue = entry.value;
        final regex = RegExp(r'\\b' + RegExp.escape(oldValue) + r'\\b');
        final matches = regex.allMatches(newContent);

        if (matches.isNotEmpty) {
          newContent = newContent.replaceAll(regex, newValue);
          changes += matches.length;
          _logChange(file.path, '图标尺寸', oldValue, newValue, matches.length);
        }
      }

      // 写入文件（如果不是预览模式）
      if (!dryRun && newContent != content) {
        file.writeAsStringSync(newContent);
      }

      return changes;
    } catch (e) {
      print('❌ 处理文件失败: ${file.path}');
      print('   错误: $e');
      return 0;
    }
  }

  void _logChange(String filePath, String type, String oldValue,
      String newValue, int count) {
    final relativePath = filePath.replaceFirst(RegExp(r'^.*lib/'), 'lib/');
    print('🔧 $relativePath');
    print('   $type: $oldValue → $newValue ($count处)');
  }
}
