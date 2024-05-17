import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academy_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to fetch enrolled academies details
final enrolledAcademiesProvider = FutureProvider<List<Academy>>((ref) async {
  // Use the academyServiceProvider to access AcademyServices
  return AcademyServices().getEnrolledAcademiesDetails();
});


