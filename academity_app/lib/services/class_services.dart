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

static Future<List<ClassSchedule>> fetchScheduleForStudent({
  required DateTime fromDate,
  required DateTime toDate,
}) async {
  print("fetchScheduleForStudent called");
  final formattedFromDate = DateFormat('yyyy-MM-dd').format(fromDate);
  final formattedToDate = DateFormat('yyyy-MM-dd').format(toDate);
  print("Formatted dates: from - $formattedFromDate, to - $formattedToDate");

  final response = await AcademityApi.get('schedule/student', {
    'from_date': formattedFromDate,
    'to_date': formattedToDate,
  });

  print("API response status: ${response.statusCode}");
  if (response.statusCode == 200) {
    print("API response body: ${response.body}");
    final List<dynamic> data = json.decode(response.body);
    print("Decoded data: $data");
    return data.map((json) => ClassSchedule.fromJson(json as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to load schedule');
  }
}



}
