import 'dart:convert';
import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/class_with_timing.dart';
import 'package:academity_app/providers/classes_provider.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


class ClassServices {

 Future<List<ClassWithTiming>> fetchClasses() async {
    final response = await AcademityApi.get('classes');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> classesJson = data['classes'];
      return classesJson.map((dynamic item) => ClassWithTiming.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }

 Future<List<ClassWithTiming>> fetchClassesByAcademyId(int academyId) async {
  try {
    final response = await http.get(Uri.parse('http://192.168.100.15:8080/api/classes/bai?academy_id=$academyId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> classesJson = responseData['classes']; // Extract 'classes' array from response
      return classesJson.map((dynamic item) => ClassWithTiming.fromJson(item)).toList();
    } else {
      print('Error fetching classes. Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load classes. Response status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching classes: $e');
    throw Exception('An error occurred while fetching classes: $e');
  }
}
}