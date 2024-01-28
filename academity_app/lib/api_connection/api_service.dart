import 'dart:convert';
import 'package:academity_app/models/class.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "http://192.168.28.119/Academity_App/Academity/api_academity"; // Your API base URL

  // Constructor
  ApiService();

  // Method to login owner
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login_user.php'),
        body: {
          'email': email,
          'password': password,
        },
      );

      // Debug statement

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'status': 'Error', 'message': 'Failed to login'};
      }
    } catch (e) {
      // Debug statement
      return {'status': 'Error', 'message': e.toString()};
    }
  }

  Future<List<dynamic>> fetchSports() async {
    try {
      final url = Uri.parse("$baseUrl/fetch_sports.php");
      // Debug URL
      final response = await http.get(url);

      // Debug Response

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load sports data');
      }
    } catch (e) {
      // Catch any errors
      return [];
    }
  }

  Future<List<dynamic>> fetchAcademies(String sportId) async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/fetch_academies.php?sportId=$sportId"));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load academies');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<List<Classes>> fetchClassesForAcademy(int academyId) async {
    final url =
        '$baseUrl/fetch_classes.php?academy_id=$academyId'; // Changed parameter name

    // Debug statement
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        return list.map((model) => Classes.fromJson(model)).toList();
      } else {
        throw Exception('Failed to load classes');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
