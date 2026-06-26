import 'dart:convert';
import 'package:academity_app/env.dart';
import 'package:academity_app/models/sport.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:academity_app/services/demo_data.dart';

class SportsService {
  // Consider extracting the host part if you're going to use it for image URL construction
  final String baseImageUrl = Env.academityUrl;

  Future<List<Sport>> fetchSports() async {
    try {
      final response = await AcademityApi.get('sport');
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        if (decodedJson['sports'] != null) {
          final sportsJson = decodedJson['sports'] as List<dynamic>;
          return sportsJson.map((item) => Sport.fromJson(item)).toList();
        }
      }
    } catch (_) {
      return DemoData.sports;
    }

    return DemoData.sports;
  }
}
