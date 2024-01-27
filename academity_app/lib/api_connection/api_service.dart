import 'dart:convert';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/models/class.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "http://192.168.28.119/Academity_App/Academity/api_academity"; // Your API base URL

  // Constructor
  ApiService();

  // Method to login owner
  Future<Map<String, dynamic>> loginOwner(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login_owner.php'),
        body: {
          'email': email,
          'password': password,
        },
      );

      print('Login response: ${response.body}'); // Debug statement

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': 'Error', 'message': 'Failed to login'};
      }
    } catch (e) {
      print('Login error: $e'); // Debug statement
      return {'status': 'Error', 'message': e.toString()};
    }
  }

  // In ApiService class

  Future<List<Academy>> fetchAcademiesByOwnerId(int ownerId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/fetch_academies.php?ownerId=$ownerId'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return List<Academy>.from(
          jsonResponse.map((model) => Academy.fromJson(model)));
    } else {
      throw Exception('Failed to load academies');
    }
  }

  Future<List<Classes>> fetchClassesForAcademy(int academyId) async {
    final url =
        '$baseUrl/fetch_classes.php?academy_id=$academyId'; // Changed parameter name

    print('Fetching classes from: $url'); // Debug statement
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        return list.map((model) => Classes.fromJson(model)).toList();
      } else {
        print('Failed to load classes. Status code: ${response.statusCode}');
        throw Exception('Failed to load classes');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Error occurred: $e');
    }
  }
}
