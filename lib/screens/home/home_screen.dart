import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../models/service_type.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/footer_widget.dart';
import '../../widgets/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CleanupAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _HeroSection(),
            const _ServicesSection(),
            const _WhyUsSection(),
            const _TrustSection(),
            const _AppDownloadSection(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

// ── 히어로 ───────────────────────────────────────────────────────────────────

class _HeroSection extends StatefulWidget {
  const _HeroSection();

  @override
  State<_HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<_HeroSection> {
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: height * 0.68),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F6FFF), Color(0xFF00C9B1)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: isWide ? -20 : -60,
            top: -60,
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            right: isWide ? 120 : -20,
            bottom: -100,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),
          Positioned(
            left: -40,
            bottom: 20,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 80 : 24,
              vertical: 72,
            ),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _HeroContent(isWide: isWide),
                      ),
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 4,
                        child: _HeroFloatingCard(),
                      ),
                    ],
                  )
                : _HeroContent(isWide: isWide),
          ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final bool isWide;
  const _HeroContent({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified, size: 13, color: Colors.white),
              SizedBox(width: 5),
              Text(
                '전문 청소 서비스 No.1',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 20),
        Text(
          '깨끗함이\n일상이 되다',
          style: TextStyle(
            fontSize: isWide ? 54 : 38,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.15,
            letterSpacing: -1,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 100.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 18),
        const Text(
          '믿을 수 있는 전문 청소사가\n생활청소부터 이사청소까지 직접 방문합니다.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.7,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 36),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _HeroButton(
              label: '생활청소 예약',
              isPrimary: true,
              onTap: () => context.go('/booking/living'),
            ),
            _HeroButton(
              label: '이사청소 예약',
              isPrimary: false,
              onTap: () => context.go('/booking/moving'),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 350.ms),
        const SizedBox(height: 36),
        Row(
          children: [
            _HeroMiniStat(value: '5,000+', label: '누적 청소'),
            _divider(),
            _HeroMiniStat(value: '98%', label: '만족도'),
            _divider(),
            _HeroMiniStat(value: '24시간', label: '예약 가능'),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
      ],
    );
  }

  Widget _divider() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        width: 1,
        height: 28,
        color: Colors.white24,
      );
}

class _HeroMiniStat extends StatelessWidget {
  final String value;
  final String label;
  const _HeroMiniStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white60),
        ),
      ],
    );
  }
}

class _HeroFloatingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          // Real cleaning photo
          SizedBox(
            height: 380,
            width: double.infinity,
            child: Image.network(
              'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: Colors.white.withValues(alpha: 0.1),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white54,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stack) => Container(
                color: Colors.white.withValues(alpha: 0.1),
                child: const Icon(Icons.cleaning_services_outlined,
                    size: 80, color: Colors.white24),
              ),
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.65),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),
          // Booking steps overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '지금 바로 예약하세요',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '5단계로 간편하게 완료!',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ('1', '주소'),
                      ('2', '일정'),
                      ('3', '옵션'),
                      ('4', '정보'),
                      ('5', '결제'),
                    ]
                        .map((step) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color:
                                        Colors.white.withValues(alpha: 0.3)),
                              ),
                              child: Text(
                                '${step.$1}. ${step.$2}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideX(begin: 0.15, end: 0);
  }
}

class _HeroButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _HeroButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.white : Colors.transparent,
        foregroundColor: isPrimary ? AppColors.primary : Colors.white,
        elevation: isPrimary ? 2 : 0,
        minimumSize: const Size(152, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: isPrimary
              ? BorderSide.none
              : const BorderSide(color: Colors.white60, width: 1.5),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Text(label),
    );
  }
}

// ── 서비스 섹션 ───────────────────────────────────────────────────────────────

class _ServicesSection extends StatelessWidget {
  const _ServicesSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 72,
      ),
      child: Column(
        children: [
          _SectionHeader(
            tag: 'OUR SERVICES',
            tagColor: AppColors.accent,
            title: '무엇을 도와드릴까요?',
            subtitle: '원하시는 청소 서비스를 선택하세요',
          ),
          const SizedBox(height: 48),
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ServiceType.values
                  .map((t) => Expanded(child: ServiceCard(serviceType: t)))
                  .expand((w) => [w, const SizedBox(width: 24)])
                  .toList()
                ..removeLast(),
            )
          else
            Column(
              children: ServiceType.values
                  .map((t) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ServiceCard(serviceType: t),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

// ── Why Us 섹션 ─────────────────────────────────────────────────────────────

class _WhyUsSection extends StatelessWidget {
  const _WhyUsSection();

  static const _items = [
    _WhyItem(
      icon: Icons.verified_user_outlined,
      title: '검증된 전문 청소사',
      desc: '모든 청소사는 신원조회 및 전문 교육을 이수한 인증 파트너입니다.',
    ),
    _WhyItem(
      icon: Icons.shield_outlined,
      title: '100% 보험 가입',
      desc: '손해배상 보험으로 서비스 중 발생하는 모든 사고를 보장합니다.',
    ),
    _WhyItem(
      icon: Icons.replay_outlined,
      title: '재청소 보장',
      desc: '서비스 완료 후 만족하지 못하신 경우 무료 재청소를 진행합니다.',
    ),
    _WhyItem(
      icon: Icons.support_agent_outlined,
      title: '24시간 고객 지원',
      desc: '예약부터 완료까지 언제든지 도움을 드립니다.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 72,
      ),
      child: Column(
        children: [
          _SectionHeader(
            tag: 'WHY CLEANUP',
            tagColor: AppColors.primary,
            title: 'cleanup을 선택하는 이유',
          ),
          const SizedBox(height: 48),
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _items
                  .map((item) => Expanded(child: _WhyCard(item: item)))
                  .expand((w) => [w, const SizedBox(width: 20)])
                  .toList()
                ..removeLast(),
            )
          else
            Column(
              children: _items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _WhyCard(item: item),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _WhyItem {
  final IconData icon;
  final String title;
  final String desc;
  const _WhyItem({required this.icon, required this.title, required this.desc});
}

class _WhyCard extends StatelessWidget {
  final _WhyItem item;
  const _WhyCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.desc,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Trust / Stats 섹션 ───────────────────────────────────────────────────────

class _TrustSection extends StatelessWidget {
  const _TrustSection();

  static const _stats = [
    _Stat(icon: Icons.star_border_rounded, value: '5,000+', label: '누적 청소 건수'),
    _Stat(icon: Icons.thumb_up_outlined, value: '98%', label: '고객 만족도'),
    _Stat(icon: Icons.calendar_today_outlined, value: '3년+', label: '서비스 운영'),
    _Stat(icon: Icons.access_time_outlined, value: '24시간', label: '예약 가능'),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F6FFF), Color(0xFF00C9B1)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 56,
      ),
      child: Column(
        children: [
          const Text(
            '고객이 신뢰하는 cleanup',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          isWide
              ? Row(
                  children: _stats
                      .map((s) => Expanded(child: _StatCard(stat: s)))
                      .expand((w) => [w, const SizedBox(width: 16)])
                      .toList()
                    ..removeLast(),
                )
              : Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _stats
                      .map((s) => SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 60) / 2,
                            child: _StatCard(stat: s),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _Stat {
  final IconData icon;
  final String value;
  final String label;
  const _Stat({required this.icon, required this.value, required this.label});
}

class _StatCard extends StatelessWidget {
  final _Stat stat;
  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(stat.icon, color: Colors.white, size: 26),
          const SizedBox(height: 10),
          Text(
            stat.value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

// ── 앱 다운로드 섹션 ──────────────────────────────────────────────────────────

class _AppDownloadSection extends StatelessWidget {
  const _AppDownloadSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Container(
      color: AppColors.textDark,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 56,
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'APP 출시 예정',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        '앱으로 더\n편리하게',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.2,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '예약, 일정 확인, 실시간 알림까지\niOS & Android 앱에서 한번에 관리하세요.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white54,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 28),
                      const _DownloadButtons(),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                Container(
                  width: 200,
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.3),
                        AppColors.accent.withValues(alpha: 0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_iphone,
                          size: 64, color: Colors.white30),
                      SizedBox(height: 8),
                      Text(
                        'Coming Soon',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '앱으로 더 편리하게',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '예약, 일정 확인, 실시간 알림까지\niOS & Android에서 한번에 관리하세요.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                    height: 1.7,
                  ),
                ),
                SizedBox(height: 24),
                _DownloadButtons(),
              ],
            ),
    );
  }
}

class _DownloadButtons extends StatelessWidget {
  const _DownloadButtons();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _StoreButton(
          icon: Icons.apple,
          storeName: 'App Store',
          subLabel: 'iPhone에서 다운로드',
        ),
        _StoreButton(
          icon: Icons.android,
          storeName: 'Google Play',
          subLabel: 'Android에서 다운로드',
        ),
      ],
    );
  }
}

class _StoreButton extends StatelessWidget {
  final IconData icon;
  final String storeName;
  final String subLabel;

  const _StoreButton({
    required this.icon,
    required this.storeName,
    required this.subLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26, color: Colors.white70),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subLabel,
                style: const TextStyle(fontSize: 10, color: Colors.white38),
              ),
              Text(
                storeName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── 공통 섹션 헤더 ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String tag;
  final Color tagColor;
  final String title;
  final String? subtitle;

  const _SectionHeader({
    required this.tag,
    required this.tagColor,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                color: tagColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              tag,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: tagColor,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                color: tagColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
            letterSpacing: -0.5,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: AppColors.textMuted),
          ),
        ],
      ],
    );
  }
}
