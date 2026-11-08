import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'detail_screen.dart';
import 'menu_screen.dart';

void main() {
  runApp(const PizzaStoreApp());
}

class PizzaStoreApp extends StatelessWidget {
  const PizzaStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      initialRoute: AppRoutes.menu,
      routes: {
        AppRoutes.menu: (context) => const MenuScreen(),
        AppRoutes.vegetable: (context) => const VegetablePizzaScreen(),
        AppRoutes.cheese: (context) => const CheesePizzaScreen(),
        AppRoutes.fries: (context) => const FriesScreen(),
      },
    );
  }
}
