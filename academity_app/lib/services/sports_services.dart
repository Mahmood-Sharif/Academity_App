import 'dart:convert';
import 'package:academity_app/models/sport.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:http/http.dart' as http;

class SportsService {
  final String baseUrl = '${AcademityApi.academityUrl}/api';
  // Consider extracting the host part if you're going to use it for image URL construction
  final String baseImageUrl = AcademityApi.academityUrl;

  Future<List<Sport>> fetchSports() async {
    final response = await http.get(Uri.parse('$baseUrl/sport')); // Ensure you're using the http package for requests
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      // Corrected to match the key in the JSON response
      if (decodedJson['sports'] != null) {
        final List<dynamic> sportsJson = decodedJson['sports'] as List<dynamic>;
        final List<Sport> sports = sportsJson.map((item) => Sport.fromJson(item)).toList();
        return sports;
      } else {
        throw Exception('Sports data is not available');
      }
    } else {
      throw Exception('Failed to load sports: ${response.body}');
    }
  }
}
