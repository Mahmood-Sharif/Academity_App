import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'academity_api.dart'; // Ensure this import points to the correct file path

class AuthServices {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final response = await AcademityApi.post(
      'login', // Fixed to use just the path part
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'Login successful' && data['token'] != null) {
        await _storage.write(key: 'jwt_token', value: data['token']);
        return true;
      }
    }
    return false;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }
}
