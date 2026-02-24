import 'package:flutter/material.dart';

import '../models/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUser? user = ModalRoute.of(context)?.settings.arguments as AppUser?;

    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: Center(
        child: Text(
          user == null ? '로그인 정보가 없습니다.' : '${user.email}님, 환영합니다.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
