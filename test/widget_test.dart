import 'package:flutter_test/flutter_test.dart';
import 'package:smart_quiz_new/main.dart';

void main() {
  testWidgets('Smart Quiz New app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Smart Quiz New'), findsOneWidget);
  });
}