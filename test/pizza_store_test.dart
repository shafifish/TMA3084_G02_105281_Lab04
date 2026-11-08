import 'package:flutter_test/flutter_test.dart';
import 'package:lab_04/main.dart';

void main() {
  testWidgets('menu lists the three items', (tester) async {
    await tester.pumpWidget(const PizzaStoreApp());

    expect(find.text('Pizza Store Menu'), findsOneWidget);
    expect(find.text('Vegetable Pizza'), findsOneWidget);
    expect(find.text('Cheese Pizza'), findsOneWidget);
    expect(find.text('Box of Fries'), findsOneWidget);
  });

  testWidgets('tapping a card opens its detail screen', (tester) async {
    await tester.pumpWidget(const PizzaStoreApp());

    await tester.tap(find.text('Cheese Pizza'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Melted mozzarella'),
      findsOneWidget,
      reason: 'the cheese pizza detail screen should be showing',
    );
    expect(find.text('Pizza Store Menu'), findsNothing);
  });

  testWidgets('the back button returns to the menu', (tester) async {
    await tester.pumpWidget(const PizzaStoreApp());

    await tester.tap(find.text('Box of Fries'));
    await tester.pumpAndSettle();
    expect(find.text('Pizza Store Menu'), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Pizza Store Menu'), findsOneWidget);
    expect(find.text('Vegetable Pizza'), findsOneWidget);
  });
}
