import 'dart:convert';
import 'package:academity_app/models/class.dart';
import 'package:academity_app/providers/classes_provider.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class ClassServices {

 Future<List<Classes>> fetchClasses() async {
    final response = await AcademityApi.get('classes');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> classesJson = data['classes'];
      return classesJson.map((dynamic item) => Classes.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }
}