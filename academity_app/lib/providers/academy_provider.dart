import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Provides an instance of AcademyServices
final academyServiceProvider = Provider<AcademyServices>((ref) {
  return AcademyServices();
});

// Fetches and provides academies by sport ID
final academiesProvider = FutureProvider.family<List<Academy>, int>((ref, sportId) {
  final academyService = ref.watch(academyServiceProvider);
  return academyService.fetchAcademiesBySportId(sportId);
});
