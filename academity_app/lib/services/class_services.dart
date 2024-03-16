// class_services.dart
import 'dart:convert';
import 'package:academity_app/services/academity_api.dart';
import 'package:academity_app/models/class.dart'; // Adjust path

class ClassServices {
  Future<List<Classes>> fetchClasses(int academyId) async {
    final response = await AcademityApi.get('academy/$academyId/classes');

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
    final response = await AcademityApi.get('class/prices/$classId');
    if (response.statusCode == 200) {
      return Classes.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load class details');
    }
  }

Future<List<Classes>> fetchScheduleForStudent(int studentId, DateTime fromDate, DateTime toDate) async {
    final response = await AcademityApi.get('schedule/student', {
      'student_id': studentId.toString(),
      'from_date': fromDate.toIso8601String(),
      'to_date': toDate.toIso8601String(),
    });

    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = json.decode(response.body);
      List<Classes> classSchedule = decodedJson.map<Classes>((json) => Classes.fromJson(json)).toList();
      return classSchedule;
    } else {
      throw Exception('Failed to fetch schedule with status code ${response.statusCode}');
    }
  }
}
