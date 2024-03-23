// class_services.dart
import 'dart:convert';
import 'package:academity_app/models/class_schedule.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:academity_app/models/class.dart';
import 'package:intl/intl.dart'; // Adjust path

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
            .map<Classes>(
                (item) => Classes.fromJson(item as Map<String, dynamic>))
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

  static Future<List<ClassSchedule>> fetchScheduleForStudent({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final formattedFromDate = DateFormat('yyyy-MM-dd').format(fromDate);
    final formattedToDate = DateFormat('yyyy-MM-dd').format(toDate);

    final response = await AcademityApi.get('schedule/student', {
      'from_date': formattedFromDate,
      'to_date': formattedToDate,
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => ClassSchedule.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  Future<bool> verifyAndLogAttendance(
      String scannedData, String studentId) async {
    final response = await AcademityApi.get('attendance/verifyAndLog', {
      'scannedData': scannedData,
      'studentId': studentId,
    });

    if (response.statusCode == 200) {
      // You can enhance this by also checking the response body if needed
      return true;
    } else {
      // Log error or handle it as needed
      return false;
    }
  }
}
