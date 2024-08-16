// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:indoortracking/screens/login_screen.dart';
import 'package:indoortracking/widgets/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final String _token;
  const SettingsScreen(this._token, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _confirmLogout() async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmar Logout',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFFF5F7F8)
                  : Color(0xFF2D2D2D),
            ),
          ),
          content: Text(
            'Você realmente deseja sair do aplicativo?',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFFF5F7F8)
                  : Color(0xFF2D2D2D),
            ),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Color(0xFF2D2D2D)
              : Color(0xFFF5F7F8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xFFF5F7F8),
                ),
              ),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 143, 20, 11),
                ),
              ),
              child: Text('Sair'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      _logout();
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', false);
    await prefs.remove('auth_token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            SizedBox(height: 16),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/user.png'),
                  fit: BoxFit.fill,
                ),
                border: Border.all(
                  color: Color(0xFF394170),
                  width: 5,
                ),
              ),
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              child: Text('Editar'),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text(
                'Redefinir senha',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFFF5F7F8)
                      : Color(0xFF2D2D2D),
                ),
              ),
              onTap: () {},
              tileColor: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF2D2D2D)
                  : Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Sair do aplicativo',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFFF5F7F8)
                      : Color(0xFF2D2D2D),
                ),
              ),
              onTap: () {
                _confirmLogout();
              },
              tileColor: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF2D2D2D)
                  : Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(context, widget._token, 1),
    );
  }
}
