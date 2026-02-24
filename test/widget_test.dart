import 'package:flutter_test/flutter_test.dart';

import 'package:zestify/app/app.dart';

void main() {
  testWidgets('Login page renders', (WidgetTester tester) async {
    await tester.pumpWidget(const ZestifyApp());

    expect(find.text('로그인'), findsNWidgets(2));
    expect(find.text('Zestify 시작하기'), findsOneWidget);
    expect(find.text('테스트 계정: test@zestify.com / 123456'), findsOneWidget);
  });
}
