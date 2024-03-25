import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academy_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final academyProvider = FutureProvider<List<Academy>>((ref) async {
  final academyService = AcademyServices();
  return academyService.fetchAcademies();
});

final CoachAcademiesProvider = FutureProvider.family<List<Academy>, int>((ref, coachId) {
  final academyService = AcademyServices();
  return academyService.fetchAcademiesByCoachId(coachId);
});