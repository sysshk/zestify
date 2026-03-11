import 'package:flutter/material.dart';
import '../app/theme.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  static const _labels = ['주소', '일정', '옵션', '정보', '결제'];

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        children: List.generate(_labels.length * 2 - 1, (i) {
          if (i.isOdd) {
            final stepIndex = i ~/ 2;
            final isDone = stepIndex < currentStep;
            return Expanded(
              child: Container(
                height: 2,
                color: isDone ? AppColors.accent : AppColors.divider,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final isDone = stepIndex < currentStep;
          final isCurrent = stepIndex == currentStep;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone
                      ? AppColors.accent
                      : isCurrent
                          ? AppColors.primary
                          : AppColors.divider,
                ),
                child: Center(
                  child: isDone
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : Text(
                          '${stepIndex + 1}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isCurrent ? Colors.white : AppColors.textMuted,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _labels[stepIndex],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                  color: isCurrent ? AppColors.primary : AppColors.textMuted,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
