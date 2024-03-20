import 'dart:convert';
import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/providers/classes_provider.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:http/http.dart' as http;

class StudentServices {
  Future<List<Student>> fetchStudentsByClassId(int classId) async {
    try {
      final url = Uri.parse('http://192.168.100.15:8080/api/enrollments/bci?class_id=$classId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((dynamic item) => Student.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load students for class $classId. Response status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching students');
    }
  }

  Future<void> markAttendance(int studentId, DateTime datetime) async {
    try {
      final url = Uri.parse('http://192.168.100.15:8080/api/attendance/$studentId?datetime=${datetime.toIso8601String()}');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        print('Attendance marked successfully for student $studentId');
      } else {
        throw Exception('Failed to mark attendance for student $studentId. Response status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while marking attendance');
    }
  }

  Future<List<Attendance>> getAttendanceList(int classId, DateTime datetime) async {
    try {
      final url = Uri.parse('http://192.168.100.15:8080/api/attendance?class_id=$classId&datetime=${datetime.toIso8601String()}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((dynamic item) => Attendance.fromJson(item)).toList();
      } else {
        throw Exception('Failed to retrieve attendance list for class $classId and datetime $datetime. Response status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while retrieving attendance list');
    }
  }
}