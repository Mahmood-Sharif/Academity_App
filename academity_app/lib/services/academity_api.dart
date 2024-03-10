import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AcademityApi {
  static const String academityHost = '192.168.100.15:8080';
  static const String academityUrl = 'http://$academityHost';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<Map<String, String>> _getHeaders() async {
    final token = await _storage.read(key: 'jwt_token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  static Future<http.Response> post(
    String path, {
    Object? body,
    Encoding? encoding,
  }) async {
    final headers = await _getHeaders();
    return http.post(
      Uri.parse('$academityUrl/api/$path'), // Adjusted to use Uri.parse for full URL
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }
}
