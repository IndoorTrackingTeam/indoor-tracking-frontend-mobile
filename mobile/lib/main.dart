// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:indoortracking/screens/splash_screen.dart';
import 'package:indoortracking/utils/dark_theme.dart';
import 'package:indoortracking/utils/light_theme.dart';

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
      home: SplashScreen(),
    );
  }
}
