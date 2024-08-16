// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, unused_field, unused_local_variable, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:indoortracking/api/user_service.dart';
import 'package:indoortracking/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

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

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        await userService.signUpEmailPassword(name, password, email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } catch (e) {
        if (e.toString().contains('email')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email já cadastrado.'),
              backgroundColor: const Color.fromARGB(255, 143, 20, 11),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Erro desconhecido: $e. Por favor, entre em contato com o suporte.'),
              backgroundColor: Color.fromARGB(255, 214, 177, 10),
            ),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 86),
            child: Padding(
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
                            key: Key("welcome_text"),
                            'Olá!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            key: Key("register_text"),
                            'Cadastre-se para continuar.',
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
                        key: Key("name_field"),
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome completo',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Coloque seu nome, por favor';
                          }
                          return null;
                        },
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
                    SizedBox(height: 24),
                    OutlinedButton(
                      key: Key("register_button"),
                      onPressed: _register,
                      child: Text('CADASTRAR'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 56),
                        maximumSize: Size(double.infinity, 56),
                      ),
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      key: Key("have_account_button"),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'Já tenho uma conta',
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
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
