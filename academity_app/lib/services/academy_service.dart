import 'dart:convert';
import 'package:academity_app/models/academy.dart';
import 'package:academity_app/services/academity_api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class AcademyServices {

Future<List<Academy>> fetchAcademies() async {
  final response = await AcademityApi.get('academies');

 if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((dynamic item) => Academy.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Academies. Response status code: ${response.statusCode}');
      }
    } 
}
