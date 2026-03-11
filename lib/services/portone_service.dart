import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

class PortOneService {
  PortOneService._();

  static void requestPayment({
    required String merchantUid,
    required String name,
    required int amount,
    required String buyerName,
    required String buyerTel,
    required void Function(Map<String, dynamic> result) onComplete,
  }) {
    final callbackName =
        'portoneCallback_${DateTime.now().millisecondsSinceEpoch}';

    globalContext[callbackName] = ((JSString jsonResult) {
      final map = jsonDecode(jsonResult.toDart) as Map<String, dynamic>;
      onComplete(map);
      globalContext.delete(callbackName.toJS);
    }).toJS;

    final params = jsonEncode({
      'pg': 'html5_inicis',
      'pay_method': 'card',
      'merchant_uid': merchantUid,
      'name': name,
      'amount': amount,
      'buyer_name': buyerName,
      'buyer_tel': buyerTel,
    });

    globalContext.callMethod(
      'requestPortonePayment'.toJS,
      params.toJS,
      callbackName.toJS,
    );
  }
}
