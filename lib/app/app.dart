import 'package:flutter/material.dart';

import 'router.dart';

class ZestifyApp extends StatelessWidget {
  const ZestifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zestify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.login,
      routes: AppRouter.routes,
    );
  }
}
