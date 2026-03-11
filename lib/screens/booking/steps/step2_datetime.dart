import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../app/theme.dart';
import '../../../models/time_slot.dart';
import '../../../providers/booking_provider.dart';
import '../../../widgets/app_button.dart';

class Step2DateTime extends StatefulWidget {
  const Step2DateTime({super.key});

  @override
  State<Step2DateTime> createState() => _Step2DateTimeState();
}

class _Step2DateTimeState extends State<Step2DateTime> {
  DateTime? _selectedDate;
  TimeSlot? _selectedSlot;

  final _firstDate = DateTime.now().add(const Duration(days: 1));
  late final _lastDate = DateTime.now().add(const Duration(days: 60));

  bool _isSunday(DateTime day) => day.weekday == DateTime.sunday;

  void _onNext() {
    final provider = context.read<BookingProvider>();
    provider.setDateTime(_selectedDate!, _selectedSlot!);
    provider.nextStep();
  }

  @override
  Widget build(BuildContext context) {
    final canProceed = _selectedDate != null && _selectedSlot != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '날짜와 시간을 선택해주세요',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '일요일은 예약이 불가합니다',
            style: TextStyle(fontSize: 13, color: AppColors.textMuted),
          ),
          const SizedBox(height: 20),
          Card(
            child: CalendarDatePicker(
              initialDate: _selectedDate ?? _firstDate,
              firstDate: _firstDate,
              lastDate: _lastDate,
              selectableDayPredicate: (day) => !_isSunday(day),
              onDateChanged: (date) => setState(() => _selectedDate = date),
            ),
          ),
          if (_selectedDate != null) ...[
            const SizedBox(height: 20),
            Text(
              '선택한 날짜: ${DateFormat('yyyy년 MM월 dd일 (E)', 'ko').format(_selectedDate!)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
          const SizedBox(height: 20),
          const Text(
            '방문 시간',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: TimeSlot.available.map((slot) {
              final isSelected = _selectedSlot?.hour == slot.hour;
              return ChoiceChip(
                label: Text(slot.display),
                selected: isSelected,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textDark,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                onSelected: (v) {
                  if (v) setState(() => _selectedSlot = slot);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
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
                  onPressed: canProceed ? _onNext : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
