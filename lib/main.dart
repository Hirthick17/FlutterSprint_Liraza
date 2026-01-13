import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: LirazaApp(),
    ),
  );
}

class LirazaApp extends StatelessWidget {
  const LirazaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LIRAZA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
