import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../app/theme.dart';
import '../../providers/auth_provider.dart';
import '../../services/social_auth_service.dart';
import '../../widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  final String? redirectAfterLogin;

  const LoginScreen({super.key, this.redirectAfterLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String? _loadingProvider;

  Future<void> _login(String provider) async {
    setState(() {
      _isLoading = true;
      _loadingProvider = provider;
    });

    try {
      final authProvider = context.read<AuthProvider>();
      final user = await switch (provider) {
        'google' => SocialAuthService.signInWithGoogle(),
        'kakao' => SocialAuthService.signInWithKakao(),
        'naver' => SocialAuthService.signInWithNaver(),
        _ => throw Exception('Unknown provider'),
      };

      if (user != null && mounted) {
        authProvider.setUser(user);
        final redirect = widget.redirectAfterLogin;
        if (redirect != null && redirect.isNotEmpty) {
          context.go(redirect);
        } else {
          context.go('/');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인에 실패했습니다: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadingProvider = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 로고
                const Text(
                  'cleanup',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '전문 청소 서비스',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 48),
                const Text(
                  '로그인하고 예약을 시작하세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '간편 로그인으로 예약하고 내역을 관리하세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                ),
                const SizedBox(height: 32),
                SocialLoginButton.kakao(
                  isLoading: _isLoading && _loadingProvider == 'kakao',
                  onPressed: _isLoading ? null : () => _login('kakao'),
                ),
                const SizedBox(height: 12),
                SocialLoginButton.naver(
                  isLoading: _isLoading && _loadingProvider == 'naver',
                  onPressed: _isLoading ? null : () => _login('naver'),
                ),
                const SizedBox(height: 12),
                SocialLoginButton.google(
                  isLoading: _isLoading && _loadingProvider == 'google',
                  onPressed: _isLoading ? null : () => _login('google'),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => context.go('/'),
                  child: const Text(
                    '로그인 없이 둘러보기',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
