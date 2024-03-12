import 'dart:convert';

import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/class_timing.dart';
import 'package:academity_app/models/class_with_timing.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:academity_app/services/class_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


final classProvider = FutureProvider<List<ClassWithTiming>>((ref) async {
  final classService = ClassServices();
  return classService.fetchClasses();
});

final classServicesProvider = Provider((ref) => ClassServices());

final classesByAcademyIdProvider = FutureProvider.family<List<ClassWithTiming>, int>((ref, academyId) async {
  final classServices = ref.watch(classServicesProvider);
  return await classServices.fetchClassesByAcademyId(academyId);
});

