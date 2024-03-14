import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academy_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/services/student_service.dart';

final academyProvider = FutureProvider<List<Academy>>((ref) async {
  final academyService = AcademyServices();
  return academyService.fetchAcademies();
});