import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/theme.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Container(
      color: AppColors.textDark,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 32,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 브랜드 + 연락처
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'cleanup',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '전문 청소 서비스',
                        style:
                            TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                      const SizedBox(height: 16),
                      const _FooterRow(
                          icon: Icons.phone,
                          text: '1234-5678 (평일 09:00~18:00)'),
                      const SizedBox(height: 6),
                      const _FooterRow(
                          icon: Icons.email, text: 'hello@cleanup.kr'),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                // 서비스 링크
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '서비스',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white54,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _FooterLink(
                          label: '생활청소',
                          onTap: () => context.go('/services/living')),
                      _FooterLink(
                          label: '이사청소',
                          onTap: () => context.go('/services/moving')),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                // 지원 링크
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '지원',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white54,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _FooterLink(
                          label: '고객지원',
                          onTap: () => context.go('/support')),
                      _FooterLink(
                          label: '파트너 지원',
                          onTap: () => context.go('/partner')),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'cleanup',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '전문 청소 서비스',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 16),
                const _FooterRow(
                    icon: Icons.phone,
                    text: '1234-5678 (평일 09:00~18:00)'),
                const SizedBox(height: 6),
                const _FooterRow(
                    icon: Icons.email, text: 'hello@cleanup.kr'),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 20,
                  runSpacing: 8,
                  children: [
                    _FooterLink(
                        label: '생활청소',
                        onTap: () => context.go('/services/living')),
                    _FooterLink(
                        label: '이사청소',
                        onTap: () => context.go('/services/moving')),
                    _FooterLink(
                        label: '고객지원',
                        onTap: () => context.go('/support')),
                    _FooterLink(
                        label: '파트너 지원',
                        onTap: () => context.go('/partner')),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white12),
          const SizedBox(height: 16),
          const Text(
            '© 2026 cleanup. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
        ],
      ),
    );
  }
}

class _FooterRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FooterRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white54),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(fontSize: 13, color: Colors.white54)),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white60,
          ),
        ),
      ),
    );
  }
}
