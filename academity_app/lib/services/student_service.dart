import 'dart:convert';
import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/services/academity_api.dart';

class StudentServices {
  Future<List<Student>> fetchStudentsByClassId(int classId) async {
    try {
      final response = await AcademityApi.get(
          'enrollments/bci', {'class_id': classId.toString()});

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((dynamic item) => Student.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to load students for class $classId. Response status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching students');
    }
  }

  Future<void> markAttendance(int studentId, DateTime datetime) async {
    try {
      final response = await AcademityApi.post('attendance/$studentId', body: {
        'datetime': datetime.toIso8601String(),
      });

      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Failed to mark attendance for student $studentId. Response status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while marking attendance');
    }
  }

  Future<List<Attendance>> getAttendanceList(
      int classId, DateTime datetime) async {
    try {
      final response = await AcademityApi.get('attendance',
          {'class_id': classId, 'datetime': datetime.toIso8601String()});

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((dynamic item) => Attendance.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to retrieve attendance list for class $classId and datetime $datetime. Response status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while retrieving attendance list');
    }
  }

}
