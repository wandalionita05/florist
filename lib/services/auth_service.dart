import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://127.0.0.1:8080/api';
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    print('REGISTER STATUS: ${response.statusCode}');
    print('REGISTER BODY: ${response.body}');

    if (response.statusCode == 201) {
      return;
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'Register gagal');
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print('LOGIN STATUS: ${response.statusCode}');
    print('LOGIN BODY: ${response.body}');

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data; // { message, user }
    } else {
      throw Exception(data['message'] ?? 'Login gagal');
    }
  }
}
