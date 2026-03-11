// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

class KakaoPostcodeService {
  KakaoPostcodeService._();

  static void openPostcode(
    void Function(String address, String postalCode) onSelect,
  ) {
    final callbackName =
        'kakaoPostcodeCallback_${DateTime.now().millisecondsSinceEpoch}';

    globalContext[callbackName] = ((JSString jsonData) {
      final data = jsonDecode(jsonData.toDart) as Map<String, dynamic>;
      final address =
          data['roadAddress'] as String? ?? data['address'] as String? ?? '';
      final postalCode = data['zonecode'] as String? ?? '';
      onSelect(address, postalCode);
      globalContext.delete(callbackName.toJS);
    }).toJS;

    globalContext.callMethod(
      'openKakaoPostcode'.toJS,
      callbackName.toJS,
    );
  }
}
