import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indexed Search App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
  useMaterial3: true,

  cardTheme: CardThemeData(
    color: const Color(0xFFFFEBEE),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(
        color: Color(0xFF7F0000),
        width: 2,
      ),
    ),
  ),
),
      home: const HomePage(),
    );
  }
}