import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/booking_provider.dart';
import 'router.dart';
import 'theme.dart';

class CleanupApp extends StatelessWidget {
  const CleanupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp.router(
        title: 'cleanup | 전문 청소 서비스',
        theme: AppTheme.light(),
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
