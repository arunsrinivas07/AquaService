import 'package:flutter_test/flutter_test.dart';

import 'package:ro_water/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RoWaterApp());

    // Verify that our app starts with the payment method screen.
    expect(find.text('Select Payment Method'), findsOneWidget);
    expect(find.text('TOTAL PAYABLE'), findsOneWidget);
    expect(find.text('₹1,250.00'), findsOneWidget);
  });
}
