import 'app_routes.dart';

/// One item on the Pizza Store menu.
class MenuItem {
  const MenuItem({
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.prepTime,
    required this.badge,
    required this.image,
    required this.routeName,
  });

  final String name;
  final String tagline;
  final String description;
  final double price;
  final String prepTime;
  final String badge;
  final String image;
  final String routeName;
}

const MenuItem vegetablePizza = MenuItem(
  name: 'Vegetable Pizza',
  tagline: 'Fresh veggies, light and tasty',
  description:
      'A crispy base topped with fresh peppers, onions, mushrooms and '
      'olives, finished with a drizzle of olive oil.',
  price: 13.90,
  prepTime: '15 min',
  badge: 'Vegetarian',
  image: 'assets/images/vegetable_pizza.png',
  routeName: AppRoutes.vegetable,
);

const MenuItem cheesePizza = MenuItem(
  name: 'Cheese Pizza',
  tagline: 'Our classic, extra cheesy',
  description:
      'Melted mozzarella over our house tomato sauce on a hand stretched '
      'base, baked until the edges blister.',
  price: 12.50,
  prepTime: '12 min',
  badge: 'Best seller',
  image: 'assets/images/cheese_pizza.png',
  routeName: AppRoutes.cheese,
);

const MenuItem boxOfFries = MenuItem(
  name: 'Box of Fries',
  tagline: 'Hot, golden and crispy',
  description:
      'Golden skin on fries, fried until crisp and finished with sea salt. '
      'Best shared, but nobody is judging.',
  price: 6.00,
  prepTime: '8 min',
  badge: 'Side',
  image: 'assets/images/box_of_fries.png',
  routeName: AppRoutes.fries,
);

const List<MenuItem> menuItems = [vegetablePizza, cheesePizza, boxOfFries];
