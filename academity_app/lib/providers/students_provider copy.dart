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
