import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/footer_widget.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      appBar: const CleanupAppBar(showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.surface,
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '고객지원',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '무엇을 도와드릴까요?',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '평일 09:00~18:00 전화 및 이메일로 상담 가능합니다.',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textMuted,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: 48,
              ),
              child: isWide
                  ? const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 260, child: _ContactSection()),
                        SizedBox(width: 60),
                        Expanded(child: _FaqSection()),
                      ],
                    )
                  : const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ContactSection(),
                        SizedBox(height: 48),
                        _FaqSection(),
                      ],
                    ),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '연락처',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 20),
        const _ContactCard(
          icon: Icons.phone,
          title: '전화 상담',
          subtitle: '1234-5678',
          desc: '평일 09:00 ~ 18:00',
        ),
        const SizedBox(height: 12),
        const _ContactCard(
          icon: Icons.email_outlined,
          title: '이메일',
          subtitle: 'hello@cleanup.kr',
          desc: '24시간 접수, 1일 이내 답변',
        ),
        const SizedBox(height: 12),
        const _ContactCard(
          icon: Icons.chat_bubble_outline,
          title: '카카오톡 채널',
          subtitle: '@cleanup',
          desc: '평일 09:00 ~ 18:00',
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String desc;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection();

  static const _faqs = [
    _Faq(
      q: '예약 취소 및 변경은 어떻게 하나요?',
      a: '서비스 예정일 24시간 전까지 고객지원 전화 또는 이메일로 연락 주시면 무료로 취소/변경이 가능합니다. 24시간 이내 취소 시 취소 수수료가 발생할 수 있습니다.',
    ),
    _Faq(
      q: '청소 서비스 시간은 얼마나 걸리나요?',
      a: '평수와 서비스 종류에 따라 다르며, 생활청소는 약 2~4시간, 이사청소는 약 4~8시간이 소요됩니다. 실제 소요 시간은 현장 상황에 따라 달라질 수 있습니다.',
    ),
    _Faq(
      q: '청소 도구와 용품은 직접 준비해야 하나요?',
      a: '아니요, 모든 청소 도구와 용품은 저희가 준비합니다. 고객님은 아무것도 준비하지 않으셔도 됩니다.',
    ),
    _Faq(
      q: '청소 중 분실/파손이 발생하면 어떻게 되나요?',
      a: '모든 청소사는 손해배상 보험에 가입되어 있습니다. 청소 중 발생한 분실/파손은 보험을 통해 보상해 드립니다.',
    ),
    _Faq(
      q: '결제는 어떤 방법으로 할 수 있나요?',
      a: '신용카드, 체크카드, 계좌이체 등 다양한 방법으로 결제 가능합니다. 결제는 예약 시 온라인으로 진행됩니다.',
    ),
    _Faq(
      q: '서비스 지역이 어디인가요?',
      a: '현재 서울 전 지역과 경기도 일부 지역에서 서비스를 제공하고 있습니다. 서비스 가능 지역은 예약 시 주소 입력 후 확인하실 수 있습니다.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '자주 묻는 질문',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: _faqs.map((faq) => _FaqTile(faq: faq)).toList(),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          '해결이 안 되셨나요?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '전화 또는 이메일로 문의해 주시면 빠르게 도와드리겠습니다.',
          style: TextStyle(fontSize: 14, color: AppColors.textMuted),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => context.go('/'),
          icon: const Icon(Icons.home_outlined, size: 18),
          label: const Text('홈으로 돌아가기'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 44),
          ),
        ),
      ],
    );
  }
}

class _Faq {
  final String q;
  final String a;
  const _Faq({required this.q, required this.a});
}

class _FaqTile extends StatelessWidget {
  final _Faq faq;
  const _FaqTile({required this.faq});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        childrenPadding:
            const EdgeInsets.fromLTRB(20, 0, 20, 16),
        title: Text(
          faq.q,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        children: [
          Text(
            faq.a,
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
