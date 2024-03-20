import 'package:academity_app/models/attendance.dart';
import 'package:academity_app/services/attendance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/services/student_service.dart';

final attendanceProvider = FutureProvider.family<List<Attendance>, Map<String, dynamic>>((ref, params) async {
  final classId = params['classId'] as int;
  final startDate = params['startDate'] as String;
  final endDate = params['endDate'] as String;

  final attendanceServices = AttendanceServices();
  return attendanceServices.fetchAttendance(classId, startDate, endDate);
});
