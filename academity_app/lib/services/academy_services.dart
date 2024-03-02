import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/academy.dart'; // Update with the correct path to your Academy model

class AcademyServices {
  final String baseUrl = 'http://192.168.28.119:8080/api';

  // Fetches academies by sport ID
  Future<List<Academy>> fetchAcademiesBySportId(int sportId) async {
    final response = await http.get(Uri.parse('$baseUrl/academies/sport/$sportId'));
    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = json.decode(response.body)['academies'];
      final List<Academy> academies = decodedJson.map((jsonItem) => Academy.fromJson(jsonItem as Map<String, dynamic>)).toList();
      return academies;
    } else {
      throw Exception('Failed to load academies');
    }
  }
}
