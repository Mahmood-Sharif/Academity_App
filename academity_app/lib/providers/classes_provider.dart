import 'package:academity_app/models/class_with_timing.dart';
import 'package:academity_app/services/class_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final classServicesProvider = Provider((ref) => ClassServices());

final classesByAcademyIdProvider = FutureProvider.family<List<ClassWithTiming>, int>((ref, academyId) async {
  final classServices = ref.watch(classServicesProvider);
  return await classServices.fetchClassesByAcademyId(academyId);
});
final classesByCoachIdProvider = FutureProvider.family<List<ClassWithTiming>, int>((ref, coachId) async {
  final classServices = ref.watch(classServicesProvider);
  return await classServices.fetchClassesByCoachId(coachId);
});
