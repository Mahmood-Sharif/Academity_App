import 'dart:convert';
import 'package:academity_app/models/users.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final authServicesProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

class AuthServices {
  Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.28.119/Academity_App/Academity/api_academity/login_user.php'), // Replace with your PHP login endpoint
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'Login successful') {
        return User.fromJson(data);
      }
    }
    return null;
  }

  void logout() {
    // Handle logout logic, possibly including clearing shared preferences
  }
}
