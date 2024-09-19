import 'package:flutter/material.dart';
import 'package:mobile/screens/splash_screen.dart';
import 'package:mobile/utils/dark_theme.dart';
import 'package:mobile/utils/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indoor Tracking',
      theme: light,
      darkTheme: dark,
      home: const SplashScreen(),
    );
  }
}
