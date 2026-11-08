import 'package:flutter/material.dart';

import 'menu_data.dart';

const Color kBrown = Color(0xFF3B2A20);
const Color kCream = Color(0xFFFDF6F0);

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Map<String, int> _order = <String, int>{};

  int get _itemCount => _order.values.fold(0, (sum, qty) => sum + qty);

  double get _orderTotal {
    var total = 0.0;
    for (final entry in _order.entries) {
      final item = menuItems.firstWhere((i) => i.name == entry.key);
      total += item.price * entry.value;
    }
    return total;
  }

  void _increment(MenuItem item) {
    setState(() {
      _order.update(item.name, (qty) => qty + 1, ifAbsent: () => 1);
    });
  }

  void _decrement(MenuItem item) {
    setState(() {
      final qty = _order[item.name] ?? 0;
      if (qty <= 1) {
        _order.remove(item.name);
      } else {
        _order[item.name] = qty - 1;
      }
    });
  }

  void _clearOrder() {
    setState(() {
      _order.clear();
    });
  }

  void _addToOrder(MenuItem item) {
    _increment(item);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${item.name} added to your order'),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  void _openOrder() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: kCream,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return OrderSheet(
              order: _order,
              total: _orderTotal,
              onAdd: (item) {
                _increment(item);
                setSheetState(() {});
              },
              onRemove: (item) {
                _decrement(item);
                setSheetState(() {});
              },
              onClear: () {
                _clearOrder();
                setSheetState(() {});
              },
              onCheckout: () {
                final messenger = ScaffoldMessenger.of(context);
                final amount = _orderTotal;
                Navigator.of(sheetContext).pop();
                _clearOrder();
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      'Order placed! Total RM ${amount.toStringAsFixed(2)}',
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      appBar: AppBar(
        title: const Text('Pizza Store Menu'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              const _OvenBanner(),
              const SizedBox(height: 20),
              Text(
                'Our Menu',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: kBrown),
              ),
              const SizedBox(height: 10),
              for (final item in menuItems)
                MenuCard(
                  item: item,
                  quantity: _order[item.name] ?? 0,
                  onAdd: () => _addToOrder(item),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _OrderBar(
        count: _itemCount,
        total: _orderTotal,
        onTap: _openOrder,
      ),
    );
  }
}

class _OvenBanner extends StatelessWidget {
  const _OvenBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kBrown,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: const [
          Icon(Icons.local_pizza, color: Colors.orange, size: 34),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fresh from the oven',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Baked to order. Ready in about 15 minutes.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onAdd,
  });

  final MenuItem item;
  final int quantity;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, item.routeName),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item.image,
                  width: 74,
                  height: 74,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 74,
                    height: 74,
                    color: Colors.deepOrange,
                    child: const Icon(
                      Icons.local_pizza,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.tagline,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          'RM ${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (quantity > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: kBrown,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'x$quantity in order',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onAdd,
                icon: const Icon(Icons.add_circle),
                color: Colors.white,
                iconSize: 28,
                tooltip: 'Add to order',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderBar extends StatelessWidget {
  const _OrderBar({
    required this.count,
    required this.total,
    required this.onTap,
  });

  final int count;
  final double total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBrown,
      child: InkWell(
        onTap: onTap,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Your order: $count items',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Total: RM ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      'View order',
                      style: TextStyle(color: Colors.orange, fontSize: 13),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.shopping_basket, color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderSheet extends StatelessWidget {
  const OrderSheet({
    super.key,
    required this.order,
    required this.total,
    required this.onAdd,
    required this.onRemove,
    required this.onClear,
    required this.onCheckout,
  });

  final Map<String, int> order;
  final double total;
  final void Function(MenuItem item) onAdd;
  final void Function(MenuItem item) onRemove;
  final VoidCallback onClear;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final entries = order.entries.toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.shopping_basket, color: Colors.deepOrange),
                SizedBox(width: 8),
                Text(
                  'Your order',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: kBrown,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (entries.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'Nothing here yet.\nTap + on an item to add it.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              )
            else
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: entries.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final item = menuItems.firstWhere(
                      (i) => i.name == entry.key,
                    );
                    final qty = entry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.image,
                              width: 46,
                              height: 46,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 46,
                                    height: 46,
                                    color: Colors.orange.shade200,
                                    child: const Icon(Icons.local_pizza),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kBrown,
                                  ),
                                ),
                                Text(
                                  'RM ${(item.price * qty).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => onRemove(item),
                            icon: const Icon(Icons.remove_circle_outline),
                            tooltip: 'Remove one',
                          ),
                          Text(
                            '$qty',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () => onAdd(item),
                            icon: const Icon(Icons.add_circle_outline),
                            tooltip: 'Add one',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kBrown,
                  ),
                ),
                Text(
                  'RM ${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: entries.isEmpty ? null : onClear,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Clear'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: entries.isEmpty ? null : onCheckout,
                    icon: const Icon(Icons.check),
                    label: const Text('Checkout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
