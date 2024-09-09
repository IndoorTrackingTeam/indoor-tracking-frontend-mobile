// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/api/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/screens/login_screen.dart';
import 'package:mobile/widgets/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final String _token;
  const SettingsScreen(this._token, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserService userService = UserService();
  Map<String, dynamic> userData = {};
  bool isLoading = true;

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
                backgroundColor: WidgetStateProperty.all(
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
                backgroundColor: WidgetStateProperty.all(
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

  Future<void> _confirmResetPassword() async {
    bool? shouldSend = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmar redefinição de senha',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFFF5F7F8)
                  : Color(0xFF2D2D2D),
            ),
          ),
          content: Text(
            'Vamos enviar um email para que você redefina sua senha de acesso?',
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
                backgroundColor: WidgetStateProperty.all(
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
                backgroundColor: WidgetStateProperty.all(
                  Color(0xFF394170),
                ),
              ),
              child: Text('Enviar'),
            ),
          ],
        );
      },
    );

    if (shouldSend == true) {
      try {
        // _sendEmail(email);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sucesso"),
              content: Text('Email enviado para ${userData['email']}'),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erro"),
              content: Text('Erro ao enviar email: ${e.toString()}'),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
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

  Future<void> _getUserData(String token) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> data = await userService.getUser(token);
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      String base64String = base64Encode(bytes);
      await userService.updateUserPhoto(widget._token, base64String);
      setState(() {
        userData['photo'] = base64String;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData(widget._token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            SizedBox(height: 16),
            isLoading
                ? Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/default.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: userData['photo'] != null &&
                                userData['photo'].isNotEmpty
                            ? MemoryImage(base64Decode(userData['photo']))
                            : AssetImage('assets/images/default.png')
                                as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(
                        color: Color(0xFF394170),
                        width: 5,
                      ),
                    ),
                  ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: _selectImage,
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
              onTap: _confirmResetPassword,
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
