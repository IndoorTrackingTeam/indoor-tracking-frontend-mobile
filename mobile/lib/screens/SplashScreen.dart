// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobile/screens/LoginScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile/screens/EquipamentsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('logged_in') ?? false;
    await Future.delayed(Duration(seconds: 2));

    if (isLoggedIn) {
      String token = prefs.getString('auth_token') ?? '';
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EquipamentsScreen(token)),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 150,
            ),
            SizedBox(height: 40),
            Text(
              'INDOOR TRACKING',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A572F),
              ),
            ),
            SizedBox(height: 40),
            SpinKitCircle(
              color: Color(0xFF1A572F),
              size: 45.0,
            ),
          ],
        ),
      ),
    );
  }
}
