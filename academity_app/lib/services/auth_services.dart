import 'dart:convert';
import 'package:academity_app/.env.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<bool> loginTest() async {
    final response = await AcademityApi.get('login-test');
    return response.statusCode == 204;
  }

  Future<bool> login(String email, String password) async {
    // here we are not using AcademityApi.get because we don't have a token
    // and /api/login does not need one
    final response = await http
        .post(Uri.http(Env.academityHost, '/api/login'), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'Login successful') {
        const secureStorage = FlutterSecureStorage();
        final apiToken = data['new_token'];
        await secureStorage.write(key: 'api_token', value: apiToken);
        return true;
      }
    }
    return false;
  }

  Future<void> logout() async {
    // Handle logout logic, possibly including clearing shared preferences
    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'api_token');
  }
}
