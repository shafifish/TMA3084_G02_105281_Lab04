# Order Summary Screen — Mini Spec

- **Purpose:** show a read only summary of the current order before checkout.
- **Inputs:** `orderItemName`, `orderQuantity` and `orderUnitPrice` from `lib/order.dart`.
- **Output:** a screen showing the item name, the quantity and the total price, plus a Back button.
- **Rules:** the total must come from `orderTotal(quantity, unitPrice)`, shown to two decimal places as `RM 25.00`.
- **Out of scope:** editing the order, tax, discounts, payment, and saving data.
- **Check:** `test/order_summary_test.dart` passes and `flutter analyze` reports no issues.
