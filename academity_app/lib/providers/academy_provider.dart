import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Provides an instance of AcademyServices

// Fetches and provides academies by sport ID
final academiesProvider = FutureProvider.family<List<Academy>, int>((ref, sportId) {
  final academyService = AcademyServices();
  return academyService.fetchAcademiesBySportId(sportId);
});
