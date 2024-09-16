import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/screens/login_screen.dart';

class MockNavigatorObserver extends NavigatorObserver {
  List<Route> pushedRoutes = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    pushedRoutes.add(route);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Testando tela de Login.', () {
    group('Testando o carregamento dos widgets da tela.', () {
      testWidgets('Deve ser exibido o campo de email corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginScreen(),
          ),
        );

        final emailField = find.byKey(const Key('email_field'));

        expect(emailField, findsOneWidget);
      });

      testWidgets('Deve ser exibido o campo de senha corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginScreen(),
          ),
        );

        final passwordField = find.byKey(const Key('password_field'));

        expect(passwordField, findsOneWidget);
      });

      testWidgets(
          'Deve ser exibido o campo de lembrar de mim corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginScreen(),
          ),
        );

        final rememberMeKey = find.byKey(const Key('remember_me_key'));

        expect(rememberMeKey, findsOneWidget);
      });

      testWidgets(
          'Deve ser exibido o botão esqueci minha senha corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginScreen(),
          ),
        );

        final forgotPasswordField =
            find.byKey(const Key('forgot_password_key'));

        expect(forgotPasswordField, findsOneWidget);
      });

      testWidgets('Deve ser exibido o botão de login corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginScreen(),
          ),
        );

        final loginButton = find.byKey(const Key('login_button'));

        expect(loginButton, findsOneWidget);
      });

      testWidgets('Deve ser exibido o botão de registrar corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginScreen(),
          ),
        );

        final registerButton = find.byKey(const Key('register_button'));

        expect(registerButton, findsOneWidget);
      });
    });

    group('Testando o funcionamento dos widgets.', () {
      testWidgets(
          'Deve pedir que o usuario coloque o email ao clicar no botão de login com o campo de email vazio.',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginScreen(),
          ),
        );

        final emailField = find.byKey(const Key('email_field'));
        final passwordField = find.byKey(const Key('password_field'));
        final loginButton = find.byKey(const Key('login_button'));

        await tester.enterText(emailField, '');
        await tester.enterText(passwordField, '1234');
        await tester.pumpAndSettle();

        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        expect(find.text('Coloque seu email, por favor'), findsOne);
      });

      testWidgets(
          'Deve pedir que o usuario coloque a senha ao clicar no botão de login com o campo de email vazio.',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: LoginScreen(),
          ),
        );

        final emailField = find.byKey(const Key('email_field'));
        final passwordField = find.byKey(const Key('password_field'));
        final loginButton = find.byKey(const Key('login_button'));

        await tester.enterText(emailField, 'teste@email.com');
        await tester.enterText(passwordField, '');
        await tester.pumpAndSettle();

        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        expect(find.text('Coloque sua senha, por favor'), findsOne);
      });

      testWidgets(
          'Deve ir para a pagina de redefinir senha ao clicar no botão de esqueci minha senha.',
          (tester) async {
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(
          MaterialApp(
            home: const LoginScreen(),
            navigatorObservers: [mockObserver],
          ),
        );

        final forgotPasswordKey = find.byKey(const Key('forgot_password_key'));
        await tester.tap(forgotPasswordKey);
        await tester.pumpAndSettle();

        expect(mockObserver.pushedRoutes.length, greaterThan(0));
      });

      testWidgets(
          'Deve ir para a pagina de registro ao clicar no botão de registrar.',
          (tester) async {
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(
          MaterialApp(
            home: const LoginScreen(),
            navigatorObservers: [mockObserver],
          ),
        );

        final registerButton = find.byKey(const Key('register_button'));
        await tester.tap(registerButton);
        await tester.pumpAndSettle();

        expect(mockObserver.pushedRoutes.length, greaterThan(0));
      });

      testWidgets(
          'Deve mudar o estado do checkbox ao clicar no texto de lembrar de mim.',
          (tester) async {
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(
          MaterialApp(
            home: const LoginScreen(),
            navigatorObservers: [mockObserver],
          ),
        );

        final rememberMeKey = find.byKey(const Key('remember_me_key'));
        await tester.tap(rememberMeKey);
        await tester.pumpAndSettle();
        final rememberMe = tester.widget<Checkbox>(rememberMeKey);
        expect(rememberMe.value, true);
      });
    });
  });
}
