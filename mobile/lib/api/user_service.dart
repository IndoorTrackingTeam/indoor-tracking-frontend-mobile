import 'dart:convert';
import 'package:http/http.dart' as http;

const String path = 'https://run-api-viicaovoda-ue.a.run.app';

class UserService {
  Future<String> signInEmailPassword(String email, String password) async {
    final url = Uri.parse('$path/user/login');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "email": email,
      "password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final oid = responseData['_id']['\$oid'];
        return oid;
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw Exception('Failed to authenticate: $errorMessage');
      }
    } catch (e) {
      throw Exception(
          'An error occurred while authenticating: ${e.toString()}');
    }
  }

  Future<String> signUpEmailPassword(
      String name, String password, String email) async {
    final url = Uri.parse('$path/user/create');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 201) {
        return 'Success';
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw Exception('Failed to register user: $errorMessage');
      }
    } catch (e) {
      throw Exception(
          'An error occurred while registering user: ${e.toString()}');
    }
  }
}
