// class_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:academity_app/models/class.dart'; // Adjust path

class ClassServices {
  final String baseUrl = 'http://192.168.28.119:8080/api';

 Future<List<Class>> fetchClasses(int academyId) async {
    final url = Uri.parse('$baseUrl/academy/$academyId/classes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> classesJson = data['classes'];
      return classesJson.map((dynamic item) => Class.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }
}
