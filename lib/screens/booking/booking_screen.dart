import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/theme.dart';
import '../../models/service_type.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/step_indicator.dart';
import 'steps/step1_address.dart';
import 'steps/step2_datetime.dart';
import 'steps/step3_options.dart';
import 'steps/step4_customer.dart';
import 'steps/step5_payment.dart';

class BookingScreen extends StatefulWidget {
  final ServiceType serviceType;

  const BookingScreen({super.key, required this.serviceType});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<BookingProvider>().setServiceType(widget.serviceType);
      }
    });
  }

  @override
  void didUpdateWidget(BookingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.serviceType != widget.serviceType) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<BookingProvider>().setServiceType(widget.serviceType);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();

    const steps = [
      Step1Address(),
      Step2DateTime(),
      Step3Options(),
      Step4Customer(),
      Step5Payment(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          '${widget.serviceType.displayName} 예약',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.divider),
        ),
      ),
      body: Column(
        children: [
          StepIndicator(currentStep: provider.currentStep),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: steps[provider.currentStep],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
