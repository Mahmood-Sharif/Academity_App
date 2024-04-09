import 'dart:convert';
import 'dart:developer';
import 'package:academity_app/env.dart';
import 'package:academity_app/models/users.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

typedef RegisterResponse = ({bool success, Map<String, dynamic>? errors});

class AuthServices {
  static Future<User?> loginTest() async {
    final response = await AcademityApi.get('login-test');
    // print(response.body);
    if (response.statusCode != 200) {
      return null;
    } else {
      return User.fromJson(jsonDecode(response.body)['user']);
    }
  }

  static Future<User> login(String email, String password) async {
    // here we are not using AcademityApi.get because we don't have a token
    // and /api/login does not need one
    final response =
        await http.post(Uri.parse('${Env.academityUrl}api/login'), body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'Login successful') {
        const secureStorage = FlutterSecureStorage();
        final apiToken = data['new_token'];
        await secureStorage.write(key: 'api_token', value: apiToken);
        log(data.toString());
        return User.fromJson(data['user']);
      } else {
        throw Exception('Login failed: ${data['message']}');
      }
    }
    throw Exception('Login failed');
  }

  static Future<RegisterResponse> registerUser(
      Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('${Env.academityUrl}api/register'),
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
    return (
      success: false,
      errors: json.decode(response.body)['errors'] as Map<String, dynamic>
    );
  }

  static Future<void> logout() async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'api_token');
  }

  static Future<User> getUserProfile() async {
    try {
      final response = await AcademityApi.get(
          'user-profile'); // Use your actual API call mechanism
      if (response.statusCode == 200) {
        // Assuming the response body is directly the JSON representation of the user
        final data = json.decode(response.body);
        // Ensure your User.fromJson constructor correctly handles the structure of `data`
        return User.fromJson(data['user']);
      } else {
        // This throws an exception if the status code is not 200
        throw Exception(
            'Failed to fetch user profile with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Rethrows an exception if there was an error in fetching or parsing the user profile data
      throw Exception('Error fetching user profile: $e');
    }
  }

  static Future<User> editUserProfile(User updatedUser) async {
    try {
      // Ensure the user payload is correctly structured as per backend requirements
      final Map<String, String> userPayload = {
        'id': updatedUser.id.toString(),
        'name': updatedUser.name
            .trim(), // Trim to remove any leading/trailing whitespace
        if (updatedUser.email != null) 'email': updatedUser.email!,
        'phone': updatedUser.phone,
        'dob': updatedUser.dob
            .toIso8601String(), // Format DateTime as ISO 8601 string
        'gender': updatedUser.gender,
      };

      // Fetch the API token securely
      const secureStorage = FlutterSecureStorage();
      final apiToken = await secureStorage.read(key: 'api_token');
      if (apiToken == null) throw Exception("API token not found");

      // Send the HTTP POST request
      final response = await AcademityApi.post(
        'profile-edit', // Replace with your actual endpoint
        body: userPayload,
      );

      if (response.statusCode == 200) {
        // Handle successful response
        final data = json.decode(response.body);
        return User.fromJson(data['user']);
      } else {
        // Handle non-200 responses
        throw Exception(
            'Failed to edit user profile with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors in making the request
      throw Exception('Error editing user profile: $e');
    }
  }
}
