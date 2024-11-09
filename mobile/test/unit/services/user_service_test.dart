import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mobile/api/user_service.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([UserService])
import 'user_service_test.mocks.dart';

void main() {
  late MockUserService mockUserService;

  setUp(() {
    mockUserService = MockUserService();
  });

  test('Mock de criação de usuário - signInEmailPassword', () async {
    when(mockUserService.signInEmailPassword("teste@gmail.com", "1234#Teste"))
        .thenAnswer((_) async => "mockUserId");

    final result = await mockUserService.signInEmailPassword(
        "teste@gmail.com", "1234#Teste");

    expect(result, "mockUserId");

    verify(mockUserService.signInEmailPassword("teste@gmail.com", "1234#Teste"))
        .called(1);
  });

  test('Cadastro de usuário com signUpEmailPassword', () async {
    when(mockUserService.signUpEmailPassword(
            "Test User", "password123", "testuser@example.com"))
        .thenAnswer((_) async => "Success");

    final result = await mockUserService.signUpEmailPassword(
        "Test User", "password123", "testuser@example.com");
    expect(result, "Success");

    verify(mockUserService.signUpEmailPassword(
            "Test User", "password123", "testuser@example.com"))
        .called(1);
  });

  test('Recupera dados de usuário com getUser', () async {
    final mockUserData = {
      "_id": "mockUserId",
      "name": "Test User",
      "email": "testuser@example.com"
    };
    when(mockUserService.getUser("mockToken"))
        .thenAnswer((_) async => mockUserData);

    final result = await mockUserService.getUser("mockToken");
    expect(result, mockUserData);

    verify(mockUserService.getUser("mockToken")).called(1);
  });

  test('Atualiza foto de perfil do usuário com updateUserPhoto', () async {
    when(mockUserService.updateUserPhoto("mockUserId", "newPhotoUrl"))
        .thenAnswer((_) async => "Success");

    final result =
        await mockUserService.updateUserPhoto("mockUserId", "newPhotoUrl");
    expect(result, "Success");

    verify(mockUserService.updateUserPhoto("mockUserId", "newPhotoUrl"))
        .called(1);
  });

  test('Envio de email para redefinição de senha com sendEmailRedefinePassword',
      () async {
    when(mockUserService.sendEmailRedefinePassword("testuser@example.com"))
        .thenAnswer(
            (_) async => "Email de redefinição de senha enviado com sucesso.");

    final result =
        await mockUserService.sendEmailRedefinePassword("testuser@example.com");
    expect(result, "Email de redefinição de senha enviado com sucesso.");

    verify(mockUserService.sendEmailRedefinePassword("testuser@example.com"))
        .called(1);
  });
}
