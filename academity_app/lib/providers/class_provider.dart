import 'package:academity_app/models/class_schedule.dart';
import 'package:academity_app/services/class_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Adjust path

final classServiceProvider = Provider<ClassServices>((ref) => ClassServices());

// final classProvider = FutureProvider.family<Classes, int>((ref, classId) async {
//   return ClassServices().fetchClassDetails(classId);
// });

// final classProviderwithAcademy =
//     FutureProvider.family<List<Classes>, int>((ref, academyId) async {
//   final classService = ref.watch(classServiceProvider);
//   return classService.fetchClasses(academyId);
// });

final scheduleForStudentProvider = FutureProvider.family<List<ClassSchedule>,
    ({DateTime fromDate, DateTime toDate})>((ref, dateRange) async {
  return await ClassServices.fetchScheduleForStudent(
      fromDate: dateRange.fromDate, toDate: dateRange.toDate);
});
