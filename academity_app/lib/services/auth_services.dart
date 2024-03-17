import 'dart:convert';
import 'package:academity_app/.env.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

typedef RegisterResponse = ({bool success, Map<String, dynamic>? errors});

class AuthServices {
  Future<bool> loginTest() async {
    final response = await AcademityApi.get('login-test');
    // print(response.body);
    return response.statusCode == 204;
  }

  Future<bool> login(String email, String password) async {
    // here we are not using AcademityApi.get because we don't have a token
    // and /api/login does not need one
    final response =
        await http.post(Uri.http(Env.academityHost, '/api/login'), body: {
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



  Future<RegisterResponse> registerUser(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.http(Env.academityHost, '/api/register'),
      body: data,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'Register successful') {
        const secureStorage = FlutterSecureStorage();
        final apiToken = responseData['new_token'];
        await secureStorage.write(key: 'api_token', value: apiToken);
        return (success: true, errors: null);
      }
    }
    return (success: false, errors:  json.decode(response.body)['errors'] as  Map<String, dynamic>);
  }

  Future<void> logout() async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'api_token');
  }
}
