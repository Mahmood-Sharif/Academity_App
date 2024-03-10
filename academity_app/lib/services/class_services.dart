// class_services.dart
import 'dart:convert';
import 'package:academity_app/services/academity_api.dart';
import 'package:http/http.dart' as http;
import 'package:academity_app/models/class.dart'; // Adjust path

class ClassServices {
  final String baseUrl = '${AcademityApi.academityUrl}/api';
  // Consider extracting the host part if you're going to use it for image URL construction
  final String baseImageUrl = AcademityApi.academityUrl;

  Future<List<Classes>> fetchClasses(int academyId) async {
    final url = Uri.parse('$baseUrl/academy/$academyId/classes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decode the response body to a dynamic type
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);

      // Access the nested list of classes using the appropriate key, e.g., 'classes'
      if (decodedJson.containsKey('classes') &&
          decodedJson['classes'] is List) {
        final List<dynamic> classesJson = decodedJson['classes'];

        // Map each item in the list to a Class object and return the list
        return classesJson
            .map<Classes>((item) => Classes.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Data format is not as expected. Expected a list of classes.');
      }
    } else {
      throw Exception(
          'Failed to load classes with status code ${response.statusCode}');
    }
  }

  Future<Classes> fetchClassDetails(int classId) async {
    final url = Uri.parse('$baseUrl/class/prices/$classId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Classes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load class details');
    }
  }
}
