import 'package:flutter_test/flutter_test.dart';

import 'package:cleanup/app/app.dart';

void main() {
  testWidgets('CleanupApp renders', (WidgetTester tester) async {
    await tester.pumpWidget(const CleanupApp());
    expect(find.text('cleanup'), findsWidgets);
  });
}
