import 'package:academity_app/services/class_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/models/class.dart'; // Adjust path

final classServiceProvider = Provider<ClassServices>((ref) => ClassServices());

final classProvider = FutureProvider.family<List<Class>, int>((ref, academyId) async {
  final classService = ref.watch(classServiceProvider);
  return classService.fetchClasses(academyId);
});
