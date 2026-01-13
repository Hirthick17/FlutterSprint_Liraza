import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:liraza/core/theme/app_theme.dart';
import 'package:liraza/features/splash/splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed (safe to ignore for UI testing): $e');
  }

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
