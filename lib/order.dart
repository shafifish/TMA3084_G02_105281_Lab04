/// The current order. Kept as simple top level values for this lab.
const String orderItemName = 'Cheese Pizza';
const int orderQuantity = 2;
const double orderUnitPrice = 12.50;

/// Returns the total price for [quantity] items at [unitPrice] each.
double orderTotal(int quantity, double unitPrice) {
  return quantity * unitPrice;
}
