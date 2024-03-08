import 'dart:convert';
import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/student.dart';
import 'package:academity_app/providers/classes_provider.dart';
import 'package:academity_app/services/academity_api.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentServices {
  Future<List<Student>> fetchStudentsByClassId(int classId) async {
    try {
      final response = await http.get(Uri.parse('http://192.168.100.15:8080/api/enrollments/bci?class_id=$classId'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((dynamic item) => Student.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load students for class $classId. Response status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while fetching students: $e');
      throw Exception('An error occurred while fetching students');
    }
  }
}