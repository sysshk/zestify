import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/footer_widget.dart';

class PartnerSupportScreen extends StatelessWidget {
  const PartnerSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      appBar: const CleanupAppBar(showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 헤더 배너
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: 60,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CLEANUP PARTNER',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '함께 성장하는\n청소 전문가를 찾습니다',
                    style: TextStyle(
                      fontSize: isWide ? 36 : 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '전문 청소사로 활동하며 안정적인 수입과 성장 기회를 얻으세요.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            // 혜택 섹션
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: 56,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '파트너 혜택',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'cleanup 파트너가 되면 다양한 혜택을 누리실 수 있습니다',
                    style: TextStyle(fontSize: 14, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 32),
                  if (isWide)
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _BenefitCard(
                            icon: Icons.monetization_on_outlined,
                            title: '안정적인 수입',
                            desc: '월 평균 300만원 이상의 안정적인 수입, 빠른 주간 정산',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _BenefitCard(
                            icon: Icons.schedule,
                            title: '자유로운 스케줄',
                            desc: '본인의 스케줄에 맞게 자유롭게 근무 일정을 설정',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _BenefitCard(
                            icon: Icons.school_outlined,
                            title: '전문 교육 제공',
                            desc: '체계적인 청소 교육과 지속적인 역량 개발 지원',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _BenefitCard(
                            icon: Icons.security,
                            title: '보험 혜택',
                            desc: '산재보험 및 손해배상 보험 가입 지원',
                          ),
                        ),
                      ],
                    )
                  else
                    const Column(
                      children: [
                        _BenefitCard(
                          icon: Icons.monetization_on_outlined,
                          title: '안정적인 수입',
                          desc: '월 평균 300만원 이상의 안정적인 수입, 빠른 주간 정산',
                        ),
                        SizedBox(height: 12),
                        _BenefitCard(
                          icon: Icons.schedule,
                          title: '자유로운 스케줄',
                          desc: '본인의 스케줄에 맞게 자유롭게 근무 일정을 설정',
                        ),
                        SizedBox(height: 12),
                        _BenefitCard(
                          icon: Icons.school_outlined,
                          title: '전문 교육 제공',
                          desc: '체계적인 청소 교육과 지속적인 역량 개발 지원',
                        ),
                        SizedBox(height: 12),
                        _BenefitCard(
                          icon: Icons.security,
                          title: '보험 혜택',
                          desc: '산재보험 및 손해배상 보험 가입 지원',
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // 진행 절차
            Container(
              color: AppColors.surface,
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: 56,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '파트너 지원 절차',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (isWide)
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _StepCard(
                            num: '01',
                            title: '지원서 제출',
                            desc: '아래 양식을 통해 기본 정보를 입력해 주세요',
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _StepCard(
                            num: '02',
                            title: '서류 심사',
                            desc: '제출하신 정보를 검토 후 1~3일 내 연락드립니다',
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _StepCard(
                            num: '03',
                            title: '면접 및 교육',
                            desc: '온라인/오프라인 인터뷰와 청소 교육 이수',
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _StepCard(
                            num: '04',
                            title: '활동 시작',
                            desc: '승인 후 바로 서비스 배정 및 활동 시작',
                          ),
                        ),
                      ],
                    )
                  else
                    const Column(
                      children: [
                        _StepCard(
                          num: '01',
                          title: '지원서 제출',
                          desc: '아래 양식을 통해 기본 정보를 입력해 주세요',
                        ),
                        SizedBox(height: 20),
                        _StepCard(
                          num: '02',
                          title: '서류 심사',
                          desc: '제출하신 정보를 검토 후 1~3일 내 연락드립니다',
                        ),
                        SizedBox(height: 20),
                        _StepCard(
                          num: '03',
                          title: '면접 및 교육',
                          desc: '온라인/오프라인 인터뷰와 청소 교육 이수',
                        ),
                        SizedBox(height: 20),
                        _StepCard(
                          num: '04',
                          title: '활동 시작',
                          desc: '승인 후 바로 서비스 배정 및 활동 시작',
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // 지원 폼
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: 56,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: const _ApplicationForm(),
                ),
              ),
            ),

            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _BenefitCard({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: AppColors.primary),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String num;
  final String title;
  final String desc;

  const _StepCard({
    required this.num,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          num,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          desc,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textMuted,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _ApplicationForm extends StatefulWidget {
  const _ApplicationForm();

  @override
  State<_ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<_ApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _regionCtrl = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _regionCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _submitted = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
        ),
        child: const Column(
          children: [
            Icon(Icons.check_circle_outline, size: 48, color: AppColors.accent),
            SizedBox(height: 16),
            Text(
              '지원서가 접수되었습니다!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '검토 후 1~3일 내에 연락드리겠습니다.',
              style: TextStyle(fontSize: 14, color: AppColors.textMuted),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '파트너 지원하기',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '기본 정보를 입력해 주시면 담당자가 연락드립니다.',
          style: TextStyle(fontSize: 14, color: AppColors.textMuted),
        ),
        const SizedBox(height: 24),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: '이름'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? '이름을 입력해 주세요' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: '연락처'),
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.isEmpty) return '연락처를 입력해 주세요';
                  if (!RegExp(r'^\d{10,11}$')
                      .hasMatch(v.replaceAll('-', ''))) {
                    return '올바른 전화번호를 입력해 주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _regionCtrl,
                decoration: const InputDecoration(labelText: '활동 가능 지역'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? '활동 가능 지역을 입력해 주세요'
                    : null,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submit,
                child: const Text('지원하기'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
