import 'dart:convert';
import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/models/postAttendance.dart';
import 'package:http/http.dart' as http;

class AttendanceServices {
  Future<List<Attendance>> fetchAttendance(int classId, String startDate, String endDate) async {
  final formattedStartDate = 1;
  final url = Uri.parse('http://192.168.100.15:8080/api/attendance/$classId/$startDate/$startDate');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((dynamic item) => Attendance.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load Attendance. Response status code: ${response.statusCode}');
  }
}

  Future<bool> updateAttendance(PostAttendance attendance) async {
final url = 'http://192.168.100.15:8080/api/attendance'; // Replace with your actual API endpoint
  try {
  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode(attendance), // Convert attendance object to JSON
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    // Attendance updated successfully
    print('Attendance updated successfully');
    return true;
  } else {
    // Handle API error or failure
    print('Failed to update attendance. Status code: ${response.statusCode}');
    return false;
  }
} catch (e) {
  // Handle network or other errors
  print('Error occurred while updating attendance: $e');
  return false;
}
  }

    Future<bool> deleteAttendance(int studentId, String dateTime) async {
    final url = 'http://192.168.100.15:8080/api/attendance/$studentId/$dateTime'; // Replace with your actual API endpoint
    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Attendance deleted successfully
        print('Attendance deleted successfully');
        return true;
      } else {
        // Handle API error or failure
        print('Failed to delete attendance. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle network or other errors
      print('Error occurred while deleting attendance: $e');
      return false;
    }
  }
}
