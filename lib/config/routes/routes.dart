import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/features/pages/home/home.dart';
import 'package:proj_passion_shoot/features/widget/method/method.dart';

class MyRoutes {
  Route? onRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/MethodContent':
        return MaterialPageRoute(
            builder: (context) =>
                const MethodContent()); // Tambahkan rute untuk MethodContent di sini
      default:
        throw Exception('Invalid Route');
    }
  }
}
