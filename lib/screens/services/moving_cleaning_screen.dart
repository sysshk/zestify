import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../models/pricing_option.dart';
import '../../models/service_type.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/footer_widget.dart';
import '../../widgets/price_table.dart';

class MovingCleaningScreen extends StatelessWidget {
  const MovingCleaningScreen({super.key});

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
                    'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=1200&q=80',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF3D5AFE), Color(0xFF1E90FF)],
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stack) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF3D5AFE), Color(0xFF1E90FF)],
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
                              '이사청소',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '새 집처럼 깨끗하게\n입주 전 전문 청소',
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
                        const Expanded(flex: 3, child: _MovingServiceDetails()),
                        const SizedBox(width: 40),
                        Expanded(
                            flex: 2,
                            child: _BookingCard(serviceType: ServiceType.moving)),
                      ],
                    )
                  : Column(
                      children: [
                        const _MovingServiceDetails(),
                        const SizedBox(height: 32),
                        _BookingCard(serviceType: ServiceType.moving),
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
                    '이사청소는 생활청소보다 더 깊은 청소를 포함합니다',
                    style: TextStyle(fontSize: 14, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 20),
                  PriceTable(options: PricingTable.moving),
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

class _MovingServiceDetails extends StatelessWidget {
  const _MovingServiceDetails();

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
    '전체 공간 바닥 청소 (청소기 + 물걸레)',
    '주방 싱크대 / 가스레인지 / 후드 청소',
    '욕실 전체 (변기, 세면대, 욕조, 타일)',
    '베란다 바닥 및 창틀',
    '붙박이장 내부 선반',
    '현관 및 신발장 내부',
    '스위치 / 콘센트 주변 오염 제거',
  ];

  static const _excluded = [
    '냉장고 / 세탁기 내부 (추가 서비스)',
    '에어컨 내부 (추가 서비스)',
    '외부 유리창 (고층)',
    '가구 이동',
    '공사 폐기물 처리',
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
              style: TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.5),
            ),
            const SizedBox(height: 20),
            ...[
              '주소 입력',
              '날짜 / 시간 선택',
              '서비스 옵션 선택',
              '고객 정보 입력',
              '결제 완료',
            ].asMap().entries.map((e) => Padding(
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
                            '${e.key + 1}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(e.value,
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.textDark)),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => context.go('/booking/${serviceType.routeParam}'),
              child: const Text('예약하기'),
            ),
          ],
        ),
      ),
    );
  }
}
