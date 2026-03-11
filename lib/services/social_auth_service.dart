import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import '../models/app_user.dart';

class SocialAuthService {
  SocialAuthService._();

  static final _auth = FirebaseAuth.instance;

  // ─── Google ────────────────────────────────────────────────────────────────
  static Future<AppUser?> signInWithGoogle() async {
    User? user;

    if (kIsWeb) {
      // Flutter Web: signInWithPopup 방식 (팝업 창 OAuth)
      final provider = GoogleAuthProvider();
      final result = await _auth.signInWithPopup(provider);
      user = result.user;
    } else {
      // Mobile: GoogleSignIn 패키지 방식
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final result = await _auth.signInWithCredential(credential);
      user = result.user;
    }

    if (user == null) return null;

    return AppUser(
      uid: user.uid,
      name: user.displayName ?? '사용자',
      email: user.email ?? '',
      provider: 'google',
      profileImageUrl: user.photoURL,
      createdAt: DateTime.now(),
    );
  }

  // ─── 카카오 ─────────────────────────────────────────────────────────────────
  static Future<AppUser?> signInWithKakao() async {
    // TODO: Kakao Developer 콘솔에서 앱 키 발급 후 구현
    throw Exception('카카오 로그인은 준비 중입니다.\n카카오 앱 키 설정 후 이용 가능합니다.');
  }

  // ─── 네이버 ─────────────────────────────────────────────────────────────────
  static Future<AppUser?> signInWithNaver() async {
    // TODO: Naver Developer 콘솔에서 Client ID 발급 후 구현
    throw Exception('네이버 로그인은 준비 중입니다.\n네이버 Client ID 설정 후 이용 가능합니다.');
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    if (!kIsWeb) {
      await GoogleSignIn().signOut();
    }
  }
}
