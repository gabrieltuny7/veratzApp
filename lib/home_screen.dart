// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // remova se não usar

/// Troque estas cores quando me enviar o design
const kPrimary = Color(0xFF6750A4);
const kBgTop = Color(0xFFF3F5FF);
const kBgBottom = Colors.white;

class VeratzApp extends StatelessWidget {
  const VeratzApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: kPrimary);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veratz',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        textTheme: GoogleFonts.poppinsTextTheme(), // trocaremos pela sua fonte
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [kBgTop, kBgBottom],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          children: [
            const Spacer(flex: 2),

            // Ilustração: troque por PNG ou SVG do seu Canva
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.35,
                maxWidth: 500,
              ),
              child: Image.asset(
                'assets/images/hero.png', // vou substituir pelo seu arquivo
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const FlutterLogo(size: 120),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Olá, De novo!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Text(
              'Sua Home do Veratz pronta para customização.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Começar'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              child: const Text('Saiba mais'),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
