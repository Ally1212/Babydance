import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// 邮箱注册(发送验证码)
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'email_verified': false},
    );
  }

  /// 验证邮箱验证码
  Future<AuthResponse> verifyEmailWithOTP({
    required String email,
    required String token,
    required String password,
  }) async {
    return await _supabase.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.signup,
    );
  }

  /// 邮箱登录
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// 登出
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// 发送密码重置邮件
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  /// 发送重置密码验证码
  Future<void> sendResetPasswordOTP(String email) async {
    await _supabase.auth.signInWithOtp(email: email, shouldCreateUser: false);
  }

  /// 验证重置密码验证码并设置新密码
  Future<AuthResponse> resetPasswordWithOTP({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    // 先验证验证码
    final response = await _supabase.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.recovery,
    );

    // 验证成功后更新密码
    if (response.session != null) {
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
    }

    return response;
  }

  /// 获取当前用户
  User? get currentUser => _supabase.auth.currentUser;

  /// 获取当前会话
  Session? get currentSession => _supabase.auth.currentSession;

  /// 监听认证状态变化
  Stream<AuthState> get onAuthStateChange => _supabase.auth.onAuthStateChange;

  /// 更新密码（需要验证旧密码）
  Future<UserResponse> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    // 先验证旧密码
    await _supabase.auth.signInWithPassword(
      email: _supabase.auth.currentUser!.email!,
      password: oldPassword,
    );

    // 验证成功后更新密码
    final response = await _supabase.auth.updateUser(
      UserAttributes(password: newPassword),
    );

    // 安全最佳实践：更新密码后强制登出
    await _supabase.auth.signOut();

    return response;
  }
}
