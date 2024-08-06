import 'dart:convert';
import 'package:http/http.dart' as http;

const String path = 'https://run-api-prod-viicaovoda-ue.a.run.app';

class EquipamentService {
  Future<List<dynamic>> getEquipaments() async {
    var url = Uri.parse("$path/equipment/read-all");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load Equipaments');
      }
    } catch (e) {
      return Future.error('Failed to $e');
    }
  }

  Future<Map<String, dynamic>> getOneEquipament(String register) async {
    var url = Uri.parse("$path/equipment/read-one?register_=$register");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load Equipament');
      }
    } catch (e) {
      return Future.error('Failed to $e');
    }
  }
}
