// class_services.dart
import 'dart:convert';
import 'package:academity_app/services/academity_api.dart';
import 'package:academity_app/models/class.dart'; // Adjust path

class ClassServices {
  Future<List<Class>> fetchClasses(int academyId) async {
    final response = await AcademityApi.get('academy/$academyId/classes');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> classesJson = data['classes'];
      return classesJson.map((dynamic item) => Class.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }
}
