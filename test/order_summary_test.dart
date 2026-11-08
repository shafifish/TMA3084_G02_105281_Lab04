import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_04/order_summary.dart';

void main() {
  testWidgets('order summary shows item, quantity and total RM 25.00', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: OrderSummaryScreen()));

    expect(find.text('Order Summary'), findsOneWidget);
    expect(find.text('Item: Cheese Pizza'), findsOneWidget);
    expect(find.text('Quantity: 2'), findsOneWidget);
    expect(find.text('Total: RM 25.00'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Back'), findsOneWidget);
  });
}
