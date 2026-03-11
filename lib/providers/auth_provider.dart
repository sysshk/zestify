import 'package:flutter/foundation.dart';
import '../models/app_user.dart';

class AuthProvider extends ChangeNotifier {
  AppUser? _user;

  AppUser? get user => _user;
  bool get isLoggedIn => _user != null;

  void setUser(AppUser? user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
