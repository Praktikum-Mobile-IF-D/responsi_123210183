import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String name;
  final String description;

  Api({
    required this.name,
    required this.description,
  });

  factory Api.fromJson(Map<String, dynamic> json) {
    return Api(
      name: json['title'] ?? '',
      description: json['body'] ?? '',
    );
  }
}

class ApiService {
  static Future<List<Api>> fetchApis() async {
    try {
      final response =
          await http.get(Uri.parse('https://jobicy.com/api/v2/remote-jobs'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((data) => Api.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load API list');
      }
    } catch (e) {
      throw Exception('Failed to fetch APIs: $e');
    }
  }
}
