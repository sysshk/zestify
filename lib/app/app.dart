import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'router.dart';

class ZestifyApp extends StatelessWidget {
  const ZestifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFE91E63),
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '30th Birthday Party',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFFFF4FA),
        appBarTheme: const AppBarTheme(centerTitle: true),
        textTheme: GoogleFonts.notoSansKrTextTheme(
          ThemeData.light().textTheme.apply(
            bodyColor: const Color(0xFF3D2445),
            displayColor: const Color(0xFF3D2445),
          ),
        ),
      ),
      initialRoute: AppRouter.login,
      routes: AppRouter.routes,
    );
  }
}
