import 'package:academity_app/models/class_schedule.dart';
import 'package:academity_app/services/class_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleForStudentProvider = FutureProvider.family<List<ClassSchedule>,
    ({DateTime fromDate, DateTime toDate})>((ref, dateRange) async {
  return await ClassServices.fetchScheduleForStudent(
      fromDate: dateRange.fromDate, toDate: dateRange.toDate);
});

final scheduleForCoachProvider = FutureProvider.family<List<ClassSchedule>,
    ({DateTime fromDate, DateTime toDate})>((ref, dateRange) async {
  return await ClassServices.fetchScheduleForCoach(
      fromDate: dateRange.fromDate, toDate: dateRange.toDate);
});
