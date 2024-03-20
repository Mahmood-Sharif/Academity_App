import 'package:academity_app/models/attendance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/services/student_service.dart';

// Provider for StudentServices
final studentServicesProvider = Provider<StudentServices>((ref) => StudentServices());

// Provider for fetching students by class ID
final studentsByClassIdProvider = FutureProvider.family<List<Student>, int>((ref, classId) async {
  final studentServices = ref.read(studentServicesProvider);
  return await studentServices.fetchStudentsByClassId(classId);
});

// Provider for marking attendance
final markAttendanceProvider = Provider.family<void, Map<String, dynamic>>((ref, attendanceData) async {
  final studentServices = ref.read(studentServicesProvider);
  final studentId = attendanceData['studentId'] as int;
  final datetime = attendanceData['datetime'] as DateTime;
  return await studentServices.markAttendance(studentId, datetime);
});

// Provider for getting attendance list
final getAttendanceListProvider = FutureProvider.family<List<Attendance>, Map<String, dynamic>>((ref, attendanceData) async {
  final studentServices = ref.read(studentServicesProvider);
  final classId = attendanceData['classId'] as int;
  final datetime = attendanceData['datetime'] as DateTime;
  return await studentServices.getAttendanceList(classId, datetime);
});