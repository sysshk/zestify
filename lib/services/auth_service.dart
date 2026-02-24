import '../models/user.dart';

class AuthService {
  Future<AppUser> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (email == 'test@zestify.com' && password == '123456') {
      return AppUser(email: email);
    }

    throw Exception('이메일 또는 비밀번호가 올바르지 않습니다. (test@zestify.com / 123456)');
  }
}
