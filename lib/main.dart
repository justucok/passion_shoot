import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/routes/routes.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final route = MyRoutes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('id_ID'),
      debugShowCheckedModeBanner: false,
      title: 'Passion.Shoot',
      onGenerateRoute: route.onRoutes,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: bgColor)),
    );
  }
}
