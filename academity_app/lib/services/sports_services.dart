import 'dart:convert';
import 'package:academity_app/models/sport.dart';
import 'package:http/http.dart' as http;

class SportsService {
  Future<List<Sport>> fetchSports() async {
    final response = await http.get(Uri.parse('http://192.168.28.119:8080/api/sport')); // Ensure you're using the http package for requests
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
