// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobile/utils/darkTheme.dart';
import 'package:mobile/utils/lightTheme.dart';
import 'package:mobile/screens/RegisterScreen.dart';

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
      home: RegisterScreen(),
    );
  }
}
