import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _baseUrl = 'http://209.38.164.226:3000';

  Future<bool> login({required String email, required String password}) async {
    final uri = Uri.parse('$_baseUrl/auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    // Temporary debug output
    print('Login status: ${response.statusCode}');
    print('Login body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final token = json['accessToken'] as String?;
      if (token == null) return false;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('accessToken', token);
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>?> register({
    required String email,
    required String password,
    required String name,
    required String surname,
    String? birthday,
    String? phoneNumber,
    String? profileImagePath,
  }) async {
    final uri = Uri.parse('$_baseUrl/users');
    
    // Build request body with required fields
    final body = <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
    };
    
    // Add optional fields if provided
    if (birthday != null && birthday.isNotEmpty) {
      body['birthday'] = birthday;
    }
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      body['phoneNumber'] = phoneNumber;
    }
    if (profileImagePath != null && profileImagePath.isNotEmpty) {
      body['profileImagePath'] = profileImagePath;
    }
    
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    // Temporary debug output
    print('Register status: ${response.statusCode}');
    print('Register body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json;
    }

    // Return null on failure - the caller can check response body for error details
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('accessToken');
  }
}