import 'dart:convert';
import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:http/http.dart' as http;

class AttendanceServices {
  Future<List<Attendance>> fetchAttendance(int classId,
      {DateTime? dateTime}) async {
    final response =
        await AcademityApi.get('attendance/$classId', {'datetime': dateTime});

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((dynamic item) => Attendance.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load Attendance. Response status code: ${response.statusCode}');
    }
  }

  Future<bool> postAttendance(
      int studentId, int classId, String status, DateTime? datetime) async {
    try {
      final response = await AcademityApi.post('post-attendance', body: {
        'student_id': studentId.toString(),
        'class_id': classId.toString(),
        'status': status,
        if (datetime != null) 'datetime': datetime.toIso8601String()
      });

      if (response.statusCode == 200) {
        // Attendance updated successfully
        return true;
      } else {
        // Handle API error or failure
        return false;
      }
    } catch (e) {
      // Handle network or other errors
      return false;
    }
  }
}
