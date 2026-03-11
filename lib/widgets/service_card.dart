import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app/theme.dart';
import '../models/service_type.dart';

class ServiceCard extends StatefulWidget {
  final ServiceType serviceType;

  const ServiceCard({super.key, required this.serviceType});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isLiving = widget.serviceType == ServiceType.living;
    final startingPrice = isLiving ? '8만원' : '12만원';
    final icon =
        isLiving ? Icons.home_outlined : Icons.local_shipping_outlined;
    final features = isLiving
        ? ['거실 / 침실 청소 및 먼지 제거', '주방 싱크대 및 가스레인지 청소', '욕실 변기 / 세면대 세정']
        : ['전체 입주 / 퇴실 완벽 청소', '주방 냉장고 내부 포함', '욕실 완벽 세정 및 소독'];
    final gradientColors = isLiving
        ? [AppColors.primary, AppColors.accent]
        : [const Color(0xFF3D5AFE), AppColors.primary];

    final photoUrl = isLiving
        ? 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800&q=80'
        : 'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=800&q=80';

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovering ? AppColors.primary.withValues(alpha: 0.3) : AppColors.divider,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: _hovering ? 0.12 : 0.05),
              blurRadius: _hovering ? 32 : 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사진 헤더
            SizedBox(
              height: 160,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    photoUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stack) => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
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
                          gradientColors[0].withValues(alpha: 0.55),
                          gradientColors[1].withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(icon, color: Colors.white, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.serviceType.displayName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '$startingPrice부터',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 본문
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.serviceType.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ...features.map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 12,
                                color: AppColors.accent,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                feature,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textDark,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context
                              .go('/services/${widget.serviceType.routeParam}'),
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 44)),
                          child: const Text('자세히 보기'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => context
                              .go('/booking/${widget.serviceType.routeParam}'),
                          style: FilledButton.styleFrom(
                              minimumSize: const Size(0, 44)),
                          child: const Text('예약하기'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
