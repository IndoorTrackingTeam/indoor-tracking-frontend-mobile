// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/api/user_service.dart';
import 'package:mobile/screens/login_screen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  UserService userService = UserService();
  final TextEditingController _emailController = TextEditingController();

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  Future<void> _sendRecoveryPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      try {
        await userService.sendEmailRedefinePassword(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Email enviado para $email. Caso não encontre, verifique a caixa de spam ou se o email foi digitado corretamente.'),
            backgroundColor: Colors.green,
          ),
        );
        sleep(Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar email: ${e.toString()}'),
            backgroundColor: Colors.amber,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFF2F2F2),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 48, right: 48, top: 36),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Redefinição de senha',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Informe um email e enviaremos um link para redefinir sua senha.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                key: Key("email_key"),
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _emailValidator,
              ),
              SizedBox(height: 24),
              OutlinedButton(
                key: Key("login_button"),
                onPressed: _sendRecoveryPassword,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56),
                  maximumSize: Size(double.infinity, 56),
                ),
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
