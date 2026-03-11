import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../app/theme.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/booking_provider.dart';
import '../../../services/firestore_service.dart';
import '../../../services/portone_service.dart';
import '../../../widgets/app_button.dart';

class Step5Payment extends StatefulWidget {
  const Step5Payment({super.key});

  @override
  State<Step5Payment> createState() => _Step5PaymentState();
}

class _Step5PaymentState extends State<Step5Payment> {
  bool _isProcessing = false;

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);

    final provider = context.read<BookingProvider>();
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.user!;
    final booking = provider.toBooking(userId: user.uid);
    final merchantUid = 'cleanup_${DateTime.now().millisecondsSinceEpoch}';

    PortOneService.requestPayment(
      merchantUid: merchantUid,
      name: '${booking.serviceType.displayName} - ${booking.sizeLabel}',
      amount: booking.totalPrice,
      buyerName: booking.customerName,
      buyerTel: booking.customerPhone,
      onComplete: (result) async {
        if (result['success'] == true) {
          final paid = booking.copyWith(
            paymentStatus: 'paid',
            portonePaymentId: result['imp_uid'] as String?,
          );
          await FirestoreService.saveBooking(paid);
          if (mounted) {
            provider.reset();
            context.go('/booking/complete');
          }
        } else {
          if (mounted) {
            setState(() => _isProcessing = false);
            final msg = result['error_msg'] as String? ?? '결제에 실패했습니다';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(msg),
                backgroundColor: AppColors.error,
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();
    final dateStr = provider.selectedDate != null
        ? DateFormat('yyyy년 MM월 dd일', 'ko').format(provider.selectedDate!)
        : '';
    final timeStr = provider.selectedTimeSlot?.display ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '예약 내용을 확인해주세요',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _SummaryRow(
                    label: '서비스',
                    value: provider.serviceType.displayName,
                  ),
                  const Divider(height: 20),
                  _SummaryRow(label: '주소', value: provider.address),
                  if (provider.addressDetail.isNotEmpty)
                    _SummaryRow(label: '', value: provider.addressDetail),
                  const Divider(height: 20),
                  _SummaryRow(
                    label: '일정',
                    value: '$dateStr $timeStr',
                  ),
                  const Divider(height: 20),
                  _SummaryRow(label: '평수', value: provider.selectedSize?.label ?? ''),
                  if (provider.selectedAddons.isNotEmpty)
                    _SummaryRow(
                      label: '추가 서비스',
                      value: provider.selectedAddons.join(', '),
                    ),
                  const Divider(height: 20),
                  _SummaryRow(
                    label: '고객명',
                    value: provider.customerName,
                  ),
                  _SummaryRow(
                    label: '연락처',
                    value: provider.customerPhone,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '최종 결제 금액',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${_fmt(provider.totalPrice)}원',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: '이전',
                  isOutlined: true,
                  onPressed: _isProcessing
                      ? null
                      : () => context.read<BookingProvider>().prevStep(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: '결제하기',
                  isLoading: _isProcessing,
                  onPressed: _isProcessing ? null : _processPayment,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _fmt(int price) {
    final s = price.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
