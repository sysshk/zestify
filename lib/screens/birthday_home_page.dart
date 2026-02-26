import 'package:flutter/material.dart';

import '../models/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUser? user = ModalRoute.of(context)?.settings.arguments as AppUser?;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF8DC7),
              Color(0xFFFFB3D9),
              Color(0xFFFFE2F2),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Card(
                  elevation: 14,
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF5FA2),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'BIRTHDAY WEEK SPECIAL',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Happy 30th\nBirthday!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 38,
                            height: 1.1,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF4B1F58),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          user == null
                              ? '지금부터 특별한 30번째 생일 파티가 시작됩니다!'
                              : '${user.email}님을 위해 준비한 화려한 파티에 초대합니다!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 22),
                        const _HighlightCard(
                          icon: Icons.cake,
                          title: '특별 이벤트',
                          detail: '미니 케이크 컷팅식 + 깜짝 캔들 서프라이즈',
                        ),
                        const SizedBox(height: 12),
                        const _HighlightCard(
                          icon: Icons.music_note,
                          title: '파티 프로그램',
                          detail: '꾸미기 풍선, 노래방, 플레이리스트로 풀파티',
                        ),
                        const SizedBox(height: 12),
                        const _HighlightCard(
                          icon: Icons.favorite,
                          title: '소중한 메시지',
                          detail: '30년의 추억, 친구들이 전하는 소중한 말들',
                        ),
                        const SizedBox(height: 22),
                        FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.celebration),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              '파티 시작 알림받기',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFFF3D8E),
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2F8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFC5DE)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFF5FA2),
            foregroundColor: Colors.white,
            child: Icon(icon),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 2),
                Text(detail),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
