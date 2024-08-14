// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indoortracking/screens/register_screen.dart';

import 'login_screen_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Testando tela de Registro', () {
    group('Testando o carregamento dos widgets da tela.', () {
      testWidgets('Deve ser exibido o texto de inicio corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final welcomeText = find.byKey(Key('welcome_text'));

        expect(welcomeText, findsOneWidget);
      });

      testWidgets(
          'Deve ser exibido o texto de instruções corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final registerText = find.byKey(Key('register_text'));

        expect(registerText, findsOneWidget);
      });

      testWidgets('Deve ser exibido o campo de nome corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final nameField = find.byKey(Key('name_field'));

        expect(nameField, findsOneWidget);
      });

      testWidgets('Deve ser exibido o campo de email corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final emailField = find.byKey(Key('email_field'));

        expect(emailField, findsOneWidget);
      });

      testWidgets('Deve ser exibido o campo de senha corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final passwordField = find.byKey(Key('password_field'));

        expect(passwordField, findsOneWidget);
      });

      testWidgets('Deve ser exibido o botão de cadastrar corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final registerButton = find.byKey(Key('register_button'));

        expect(registerButton, findsOneWidget);
      });

      testWidgets(
          'Deve ser exibido o botão de ir para o login corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final haveAccountButton = find.byKey(Key('have_account_button'));

        expect(haveAccountButton, findsOneWidget);
      });
    });

    group('Testando o funcionamento do registro.', () {
      testWidgets(
          'Deve pedir que o usuario coloque o nome ao clicar no botão de cadastro com o campo de nome vazio.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final nameField = find.byKey(Key('name_field'));
        final emailField = find.byKey(Key('email_field'));
        final passwordField = find.byKey(Key('password_field'));
        final registerButton = find.byKey(Key('register_button'));

        await tester.enterText(nameField, '');
        await tester.enterText(emailField, 'teste@email.com');
        await tester.enterText(passwordField, '123456');
        await tester.pumpAndSettle();

        await tester.tap(registerButton);
        await tester.pumpAndSettle();

        expect(find.text('Coloque seu nome, por favor'), findsOne);
      });

      testWidgets(
          'Deve pedir que o usuario coloque o email ao clicar no botão de cadastro com o campo de email vazio.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final nameField = find.byKey(Key('name_field'));
        final emailField = find.byKey(Key('email_field'));
        final passwordField = find.byKey(Key('password_field'));
        final registerButton = find.byKey(Key('register_button'));

        await tester.enterText(nameField, 'teste');
        await tester.enterText(emailField, '');
        await tester.enterText(passwordField, '123456');
        await tester.pumpAndSettle();

        await tester.tap(registerButton);
        await tester.pumpAndSettle();

        expect(find.text('Coloque seu email, por favor'), findsOne);
      });

      testWidgets(
          'Deve pedir que o usuario coloque a senha ao clicar no botão de cadastro com o campo de senha vazio.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final nameField = find.byKey(Key('name_field'));
        final emailField = find.byKey(Key('email_field'));
        final passwordField = find.byKey(Key('password_field'));
        final registerButton = find.byKey(Key('register_button'));

        await tester.enterText(nameField, 'teste');
        await tester.enterText(emailField, 'teste@email.com');
        await tester.enterText(passwordField, '');
        await tester.pumpAndSettle();

        await tester.tap(registerButton);
        await tester.pumpAndSettle();

        expect(find.text('Coloque sua senha, por favor'), findsOne);
      });

      testWidgets(
          'Deve pedir que o usuario coloque o email corretamente ao digitar um email inválido.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final nameField = find.byKey(Key('name_field'));
        final emailField = find.byKey(Key('email_field'));
        final passwordField = find.byKey(Key('password_field'));
        final registerButton = find.byKey(Key('register_button'));

        await tester.enterText(nameField, 'teste');
        await tester.enterText(emailField, 'teste@email');
        await tester.enterText(passwordField, '123456');
        await tester.pumpAndSettle();

        await tester.tap(registerButton);
        await tester.pumpAndSettle();

        expect(find.text('Coloque um email válido, por favor'), findsOne);
      });

      testWidgets(
          'Deve ir para a pagina de login ao clicar no botão de "já tenho uma conta".',
          (tester) async {
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
            navigatorObservers: [mockObserver],
          ),
        );

        final haveAccountButton = find.byKey(Key('have_account_button'));
        await tester.tap(haveAccountButton);
        await tester.pumpAndSettle();

        expect(mockObserver.pushedRoutes.length, greaterThan(0));
      });
    });
  });
}
