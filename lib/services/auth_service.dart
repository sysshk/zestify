import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<AppUser> login({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userEmail = credential.user?.email ?? email;
      return AppUser(email: userEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'invalid-credential':
          throw Exception('이메일 또는 비밀번호가 올바르지 않습니다.');
        case 'wrong-password':
          throw Exception('비밀번호가 올바르지 않습니다.');
        case 'invalid-email':
          throw Exception('올바른 이메일 형식이 아닙니다.');
        case 'user-disabled':
          throw Exception('비활성화된 계정입니다.');
        case 'too-many-requests':
          throw Exception('잠시 후 다시 시도해주세요.');
        default:
          throw Exception('로그인 중 오류가 발생했습니다.');
      }
    }
  }
}
