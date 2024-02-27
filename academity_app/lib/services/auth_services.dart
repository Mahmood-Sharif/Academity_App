import 'dart:convert';
import 'package:academity_app/models/users.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServicesProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

class AuthServices {
  Future<User?> login(String email, String password) async {
    final response = await AcademityApi.post('login', body: {
      'email': email,
      'password': password,
    });

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
