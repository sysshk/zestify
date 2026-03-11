import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/theme.dart';
import '../../../models/pricing_option.dart';
import '../../../providers/booking_provider.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/price_table.dart';

class Step3Options extends StatelessWidget {
  const Step3Options({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();
    final options = PricingTable.forService(provider.serviceType);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '청소 면적과 옵션을 선택해주세요',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '공간 크기에 맞는 요금이 적용됩니다',
            style: TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          PriceTable(
            options: options,
            selected: provider.selectedSize,
            onSelect: (opt) => context.read<BookingProvider>().setSizeOption(opt),
          ),
          const SizedBox(height: 28),
          const Text(
            '추가 서비스 (선택)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ...PricingTable.addons.map((addon) {
            final isSelected = provider.selectedAddons.contains(addon.label);
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.05)
                  : AppColors.surface,
              child: CheckboxListTile(
                value: isSelected,
                onChanged: (v) =>
                    context.read<BookingProvider>().toggleAddon(addon.label),
                title: Text(
                  addon.label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
                subtitle: Text(
                  '+${_fmt(addon.price)}원',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                activeColor: AppColors.primary,
                controlAffinity: ListTileControlAffinity.trailing,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '예상 금액',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  '${_fmt(provider.totalPrice)}원~',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
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
                  onPressed: () => context.read<BookingProvider>().prevStep(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: '다음',
                  onPressed: provider.step3Valid
                      ? () => context.read<BookingProvider>().nextStep()
                      : null,
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
