import 'dart:convert';
import 'package:http/http.dart' as http;

const String path = 'https://run-api-prod-viicaovoda-ue.a.run.app';

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
        final id = responseData['_id'];
        return id;
      } else {
        throw Exception(jsonDecode(response.body)['param']);
      }
    } catch (e) {
      throw Exception(e.toString());
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
        throw Exception(jsonDecode(response.body)['detail']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
