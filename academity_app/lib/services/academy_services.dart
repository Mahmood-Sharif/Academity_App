import 'dart:convert';
import 'package:academity_app/services/academity_api.dart';
import 'package:http/http.dart' as http;
import '../models/academy.dart'; // Make sure this path is correct

class AcademyServices {
  final String baseUrl = '${AcademityApi.academityUrl}/api';
  // Consider extracting the host part if you're going to use it for image URL construction
  final String baseImageUrl = '${AcademityApi.academityUrl}/';

  Future<List<Academy>> fetchAcademiesBySportId(int sportId) async {
    final response = await http.get(Uri.parse('$baseUrl/academies/sport/$sportId'));
    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = json.decode(response.body)['academies'];
      final List<Academy> academies = decodedJson.map((jsonItem) {
        // Ensure image URLs are fully qualified before creating Academy objects
        Map<String, dynamic> academyData = Map.from(jsonItem as Map<String, dynamic>);
        String relativeImageUrl = academyData['image_url'];
        academyData['image_url'] = baseImageUrl + relativeImageUrl; // Construct the full image URL
        return Academy.fromJson(academyData);
      }).toList();
      return academies;
    } else {
      throw Exception('Failed to load academies');
    }
  }
}
