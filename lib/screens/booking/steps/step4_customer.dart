import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/theme.dart';
import '../../../providers/booking_provider.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';

class Step4Customer extends StatefulWidget {
  const Step4Customer({super.key});

  @override
  State<Step4Customer> createState() => _Step4CustomerState();
}

class _Step4CustomerState extends State<Step4Customer> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _onNext() {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<BookingProvider>();
    provider.setCustomerInfo(_nameCtrl.text.trim(), _phoneCtrl.text.trim());
    provider.nextStep();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '고객 정보를 입력해주세요',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '예약 확인 및 연락에 사용됩니다',
              style: TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
            const SizedBox(height: 28),
            AppTextField(
              label: '이름',
              controller: _nameCtrl,
              hint: '홍길동',
              validator: (v) {
                if (v == null || v.trim().isEmpty) return '이름을 입력해주세요';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: '휴대폰 번호',
              controller: _phoneCtrl,
              hint: "'-' 없이 숫자만 입력 (예: 01012345678)",
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return '휴대폰 번호를 입력해주세요';
                if (!RegExp(r'^\d{10,11}$').hasMatch(v.trim())) {
                  return '올바른 휴대폰 번호를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: '이전',
                    isOutlined: true,
                    onPressed: () =>
                        context.read<BookingProvider>().prevStep(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: '다음',
                    onPressed: _onNext,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
