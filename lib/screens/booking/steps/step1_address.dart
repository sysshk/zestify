import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/theme.dart';
import '../../../providers/booking_provider.dart';
import '../../../services/kakao_postcode_service.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_field.dart';

class Step1Address extends StatefulWidget {
  const Step1Address({super.key});

  @override
  State<Step1Address> createState() => _Step1AddressState();
}

class _Step1AddressState extends State<Step1Address> {
  final _addressCtrl = TextEditingController();
  final _postalCtrl = TextEditingController();
  final _detailCtrl = TextEditingController();

  @override
  void dispose() {
    _addressCtrl.dispose();
    _postalCtrl.dispose();
    _detailCtrl.dispose();
    super.dispose();
  }

  void _searchAddress() {
    KakaoPostcodeService.openPostcode((address, postalCode) {
      setState(() {
        _addressCtrl.text = address;
        _postalCtrl.text = postalCode;
      });
    });
  }

  void _onNext() {
    final provider = context.read<BookingProvider>();
    provider.setAddress(
      _addressCtrl.text.trim(),
      _detailCtrl.text.trim(),
      _postalCtrl.text.trim(),
    );
    provider.nextStep();
  }

  @override
  Widget build(BuildContext context) {
    final hasAddress = _addressCtrl.text.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '청소할 주소를 알려주세요',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '정확한 주소 입력이 필요합니다',
            style: TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: '도로명 주소',
                  controller: _addressCtrl,
                  readOnly: true,
                  hint: '주소 검색 버튼을 눌러주세요',
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: _searchAddress,
                  child: const Text('주소 검색'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          AppTextField(
            label: '우편번호',
            controller: _postalCtrl,
            readOnly: true,
          ),
          const SizedBox(height: 14),
          AppTextField(
            label: '상세주소',
            controller: _detailCtrl,
            hint: '동/호수, 층 등 (예: 101동 202호)',
            onTap: () => setState(() {}),
          ),
          const Spacer(),
          AppButton(
            text: '다음',
            onPressed: (hasAddress && _detailCtrl.text.isNotEmpty)
                ? _onNext
                : null,
          ),
        ],
      ),
    );
  }
}
