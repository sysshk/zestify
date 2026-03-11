import 'package:flutter/material.dart';
import '../app/theme.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Widget icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
  });

  factory SocialLoginButton.kakao({
    VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SocialLoginButton(
      label: '카카오로 계속하기',
      backgroundColor: AppColors.kakaoYellow,
      textColor: const Color(0xFF3A1D1D),
      icon: Image.network(
        'https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png',
        width: 20,
        height: 20,
        errorBuilder: (_, _, err) => const Icon(Icons.chat_bubble, size: 20, color: Color(0xFF3A1D1D)),
      ),
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }

  factory SocialLoginButton.naver({
    VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SocialLoginButton(
      label: '네이버로 계속하기',
      backgroundColor: AppColors.naverGreen,
      textColor: Colors.white,
      icon: const Text(
        'N',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }

  factory SocialLoginButton.google({
    VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SocialLoginButton(
      label: 'Google로 계속하기',
      backgroundColor: AppColors.googleWhite,
      textColor: AppColors.textDark,
      icon: Image.network(
        'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
        width: 20,
        height: 20,
        errorBuilder: (_, _, err) => const Icon(Icons.g_mobiledata, size: 24),
      ),
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          side: backgroundColor == AppColors.googleWhite
              ? const BorderSide(color: AppColors.divider)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
