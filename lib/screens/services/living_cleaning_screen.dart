import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../models/pricing_option.dart';
import '../../models/service_type.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/footer_widget.dart';
import '../../widgets/price_table.dart';

class LivingCleaningScreen extends StatelessWidget {
  const LivingCleaningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      appBar: const CleanupAppBar(showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 헤로 배너 (실제 사진)
            SizedBox(
              height: isWide ? 320 : 220,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=1200&q=80',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF1E90FF), Color(0xFF00C9B1)],
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stack) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1E90FF), Color(0xFF00C9B1)],
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.25),
                          Colors.black.withValues(alpha: 0.65),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 80 : 24,
                        vertical: 32,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '생활청소',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '일상 속 깨끗함을\n전문가에게 맡기세요',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: 48,
              ),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 3, child: _ServiceDetails()),
                        const SizedBox(width: 40),
                        Expanded(flex: 2, child: _BookingCard(serviceType: ServiceType.living)),
                      ],
                    )
                  : Column(
                      children: [
                        const _ServiceDetails(),
                        const SizedBox(height: 32),
                        _BookingCard(serviceType: ServiceType.living),
                      ],
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '요금 안내',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '평수에 따라 기본 요금이 달라집니다',
                    style: TextStyle(fontSize: 14, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 20),
                  PriceTable(options: PricingTable.living),
                ],
              ),
            ),
            const SizedBox(height: 60),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

class _ServiceDetails extends StatelessWidget {
  const _ServiceDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '서비스 포함 항목',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        ..._included.map((item) => _CheckItem(label: item, included: true)),
        const SizedBox(height: 24),
        const Text(
          '서비스 미포함 항목',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        ..._excluded.map((item) => _CheckItem(label: item, included: false)),
      ],
    );
  }

  static const _included = [
    '거실 / 침실 청소 및 먼지 제거',
    '주방 싱크대 주변 및 가스레인지 청소',
    '욕실 변기 / 세면대 / 타일 청소',
    '바닥 청소기 및 물걸레 청소',
    '창틀 먼지 제거',
    '쓰레기 수거 및 정리',
  ];

  static const _excluded = [
    '냉장고 / 세탁기 내부 (추가 서비스)',
    '베란다 외부 유리창',
    '가구 이동을 필요로 하는 청소',
    '공사 후 분진 / 특수 오염',
  ];
}

class _CheckItem extends StatelessWidget {
  final String label;
  final bool included;

  const _CheckItem({required this.label, required this.included});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            included ? Icons.check_circle_outline : Icons.cancel_outlined,
            size: 18,
            color: included ? AppColors.accent : AppColors.textMuted,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: included ? AppColors.textDark : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final ServiceType serviceType;

  const _BookingCard({required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '지금 바로 예약하세요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '간편한 5단계로\n빠르게 예약 완료!',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const _BookingStep(step: '1', label: '주소 입력'),
            const _BookingStep(step: '2', label: '날짜 / 시간 선택'),
            const _BookingStep(step: '3', label: '서비스 옵션 선택'),
            const _BookingStep(step: '4', label: '고객 정보 입력'),
            const _BookingStep(step: '5', label: '결제 완료'),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () =>
                  context.go('/booking/${serviceType.routeParam}'),
              child: const Text('예약하기'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingStep extends StatelessWidget {
  final String step;
  final String label;

  const _BookingStep({required this.step, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}
