import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app/theme.dart';
import '../providers/auth_provider.dart';
import '../services/social_auth_service.dart';

class CleanupAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const CleanupAppBar({super.key, this.showBackButton = false});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isWide = MediaQuery.of(context).size.width >= 768;

    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      toolbarHeight: 64,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (showBackButton) ...[
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
              onPressed: () =>
                  context.canPop() ? context.pop() : context.go('/'),
            ),
            const SizedBox(width: 4),
          ],
          GestureDetector(
            onTap: () => context.go('/'),
            child: const Text(
              'cleanup',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
                letterSpacing: -0.5,
              ),
            ),
          ),
          if (isWide) ...[
            const SizedBox(width: 32),
            _NavLink(label: '생활청소', path: '/services/living'),
            const SizedBox(width: 20),
            _NavLink(label: '이사청소', path: '/services/moving'),
            const SizedBox(width: 20),
            _NavLink(label: '고객지원', path: '/support'),
            const SizedBox(width: 20),
            _NavLink(label: '파트너 지원', path: '/partner'),
          ],
        ],
      ),
      actions: [
        if (authProvider.isLoggedIn) ...[
          if (isWide)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                '${authProvider.user!.name}님',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textMuted),
            tooltip: '로그아웃',
            onPressed: () async {
              await SocialAuthService.signOut();
              if (context.mounted) {
                context.read<AuthProvider>().logout();
                context.go('/');
              }
            },
          ),
        ] else
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () => context.go('/login'),
              child: const Text(
                '로그인',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, color: AppColors.divider),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String path;

  const _NavLink({required this.label, required this.path});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(path),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
