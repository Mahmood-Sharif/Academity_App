import 'dart:convert';
import 'package:academity_app/env.dart';
import 'package:academity_app/models/sport.dart';
import 'package:academity_app/services/academity_api.dart';

class SportsService {
  // Consider extracting the host part if you're going to use it for image URL construction
  final String baseImageUrl = Env.academityUrl;

  Future<List<Sport>> fetchSports() async {
    final response = await AcademityApi.get('sport');
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      // Corrected to match the key in the JSON response
      if (decodedJson['sports'] != null) {
        final List<dynamic> sportsJson = decodedJson['sports'] as List<dynamic>;
        final List<Sport> sports =
            sportsJson.map((item) => Sport.fromJson(item)).toList();
        return sports;
      } else {
        throw Exception('Sports data is not available');
      }
    } else {
      throw Exception('Failed to load sports: ${response.body}');
    }
  }
}
