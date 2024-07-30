// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, unused_field, unused_local_variable, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:mobile/api/user_service.dart';
import 'package:mobile/screens/equipaments_screen.dart';
import 'package:mobile/screens/password_screen.dart';
import 'package:mobile/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoggedIn = false;
  String _token = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Coloque seu email, por favor';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Coloque um email válido, por favor';
    }
    return null;
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        _token = await userService.signInEmailPassword(email, password);
        await _saveLogin(_token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EquipamentsScreen(_token),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _saveLogin(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', true);
    await prefs.setString('auth_token', token);
    setState(() {
      _isLoggedIn = true;
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá novamente!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Seja bem-vindo.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                child: TextFormField(
                  key: Key("email_field"),
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: _emailValidator,
                ),
              ),
              SizedBox(height: 24),
              Container(
                child: TextFormField(
                  key: Key("password_field"),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Coloque sua senha, por favor';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    key: Key("remember_me_key"),
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                    side: BorderSide(width: 1),
                  ),
                  Text(
                    'Lembrar de mim',
                  ),
                  Spacer(),
                  GestureDetector(
                    key: Key("forgot_password_key"),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
              OutlinedButton(
                key: Key("login_button"),
                onPressed: _login,
                child: Text('LOGIN'),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                  maximumSize: Size(double.infinity, 56),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                key: Key("register_button"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  'Não tem uma conta? Registre-se',
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
