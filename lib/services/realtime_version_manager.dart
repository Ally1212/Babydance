import 'dart:io';

/// 版本数据模型
class NewVersionData {
  final String version;
  final List<String> info;
  final String updateType;
  final String minSupportVersion;
  final bool canSkip;
  final int skipDays;
  final String downloadUrl;
  final int rolloutPercentage;

  NewVersionData({
    required this.version,
    required this.info,
    required this.updateType,
    this.minSupportVersion = '1.0.0',
    required this.canSkip,
    required this.skipDays,
    required this.downloadUrl,
    this.rolloutPercentage = 100,
  });

  /// 从 JSON 创建对象
  factory NewVersionData.fromJson(Map<String, dynamic> json) {
    return NewVersionData(
      version: json['version'] ?? '1.0.0',
      info: List<String>.from(json['info'] ?? []),
      updateType: json['updateType'] ?? 'optional',
      minSupportVersion: json['minSupportVersion'] ?? '1.0.0',
      canSkip: json['canSkip'] ?? true,
      skipDays: json['skipDays'] ?? 7,
      downloadUrl: json['downloadUrl'] ?? '',
      rolloutPercentage: json['rolloutPercentage'] ?? 100,
    );
  }

  /// 从 Supabase 响应创建对象
  factory NewVersionData.fromSupabase(Map<String, dynamic> data) {
    return NewVersionData(
      version: data['version'] ?? '1.0.0',
      info: List<String>.from(data['update_info'] ?? []),
      updateType: data['update_type'] ?? 'optional',
      minSupportVersion: data['min_support_version'] ?? '1.0.0',
      canSkip: data['can_skip'] ?? true,
      skipDays: data['skip_days'] ?? 7,
      downloadUrl: data['download_url'] ?? '',
      rolloutPercentage: data['rollout_percentage'] ?? 100,
    );
  }
}

/// 实时版本管理器（简化版本，不依赖 Supabase）
class RealtimeVersionManager {
  static Function(NewVersionData)? _onVersionUpdate;

  /// 开始监听版本更新
  static void startListening({
    required Function(NewVersionData) onVersionUpdate,
  }) {
    _onVersionUpdate = onVersionUpdate;
    print('版本监听已启动 - 平台: ${Platform.isIOS ? 'iOS' : 'Android'}');

    // 模拟版本更新通知（用于测试）
    _simulateVersionUpdate();
  }

  /// 停止监听
  static void stopListening() {
    _onVersionUpdate = null;
    print('版本监听已停止');
  }

  /// 模拟版本更新（用于测试）
  static void _simulateVersionUpdate() {
    // 延迟5秒后模拟一个版本更新
    Future.delayed(Duration(seconds: 5), () {
      if (_onVersionUpdate != null) {
        final mockVersion = NewVersionData(
          version: '1.0.1',
          info: ['修复了一些bug', '提升了性能'],
          updateType: 'optional',
          canSkip: true,
          skipDays: 7,
          downloadUrl: 'https://example.com/download',
        );
        _onVersionUpdate!(mockVersion);
      }
    });
  }

  /// 手动触发版本检查
  static void triggerVersionCheck() {
    if (_onVersionUpdate != null) {
      final mockVersion = NewVersionData(
        version: '1.0.2',
        info: ['新增了一些功能', '优化了用户体验'],
        updateType: 'recommended',
        canSkip: true,
        skipDays: 3,
        downloadUrl: 'https://example.com/download',
      );
      _onVersionUpdate!(mockVersion);
    }
  }
}

/// 使用示例
class VersionUpdateListener {
  static void init() {
    RealtimeVersionManager.startListening(
      onVersionUpdate: (newVersion) {
        print('检测到新版本: ${newVersion.version}');
        print('更新类型: ${newVersion.updateType}');
        print('更新内容: ${newVersion.info.join(', ')}');

        // 可以在这里触发版本检查
        // checkAppVersion(forceUpdate: true);
      },
    );
  }

  static void dispose() {
    RealtimeVersionManager.stopListening();
  }
}
