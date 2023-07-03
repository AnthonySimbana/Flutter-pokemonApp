import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'screens/category_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
          child: const CategoryScreen()),
    );
  }
}
