import 'dart:convert';
import 'package:academity_app/services/academity_api.dart';
import '../models/academy.dart'; // Update with the correct path to your Academy model

class NotFound extends Error {}

class AcademyServices {
  // Fetches academies by sport ID
  Future<List<Academy>> fetchAcademiesBySportId(int sportId) async {
    final response = await AcademityApi.get('academies/sport/$sportId');
    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = json.decode(response.body)['academies'];
      final List<Academy> academies = decodedJson
          .map((jsonItem) => Academy.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
      return academies;
    } else {
      throw Exception('Failed to load academies');
    }
  }

  Future<List<Academy>> getEnrolledAcademiesDetails() async {
    final response = await AcademityApi.get('enrolled/academy');

    if (response.statusCode == 200) {
      // Parse the JSON response into a list of Academy objects
      final List<dynamic> decodedResponse =
          json.decode(response.body)['academiesDetails'];
      List<Academy> academies =
          decodedResponse.map((json) => Academy.fromJson(json)).toList();
      return academies;
    } else {
      // Handle HTTP errors here
      if (response.statusCode == 404) throw NotFound();
      throw Exception('Failed to load academy details');
    }
  }

  // Function to enroll a student in a class with a registration code
  Future<bool> enrollStudentWithCode(String regCode) async {
    final response = await AcademityApi.post(
      'enrol',
      body: {'regCode': regCode},
    );

    if (response.statusCode == 200) {
      // Successfully created the enrollment
      return true;
    } else {
      // Handle different statuses or errors accordingly
      if (jsonDecode(response.body)['messages']?['error'] ==
          'Already enrolled in this class') {
        throw Exception('You are already enrolled in this class');
      }
      throw Exception(
          'Enrollment failed. Please check the code and try again.');
    }
  }

  Future<List<Academy>> fetchAcademiesByCoachId() async {
    final response = await AcademityApi.get('academies/bci');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((dynamic item) => Academy.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load Academies. Response status code: ${response.statusCode}');
    }
  }
}
