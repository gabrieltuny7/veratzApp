import 'package:flutter/material.dart';
import 'home/home.dart';

void main() => runApp(const VeratzApp());

class VeratzApp extends StatelessWidget {
  const VeratzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veratz',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6750A4),
      ),
      home: const Home(),
    );
  }
}
