import 'dart:convert';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academity_api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class AcademyServices {

Future<List<Academy>> fetchAcademies() async {
  final response = await AcademityApi.get('academies');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic>? academiesJson = data['hello'];

    if (academiesJson != null) {
      return academiesJson.map((dynamic item) => Academy.fromJson(item)).toList();
    } else {
      throw Exception('Academies data is null');
    }
  } else {
    throw Exception('Failed to load Academies');
  }
}
}