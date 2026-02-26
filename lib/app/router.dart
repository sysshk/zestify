import 'package:flutter/material.dart';
import 'package:zestify/screens/birthday_home_page.dart';
import 'package:zestify/screens/login_page.dart';

class AppRouter {
  static const String login = '/';
  static const String home = '/home';

  static final Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginPage(),
    home: (_) => const HomePage(),
  };
}
