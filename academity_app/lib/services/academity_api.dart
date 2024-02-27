import 'dart:convert';

import 'package:http/http.dart' as http;

class AcademityApi {
  /// The address of the Academity server
  static const academityHost = '192.168.28.33:8080';

  /// Perform an HTTP GET request to the Academity Api.
  ///
  /// Performs an api request to [path] prefixed with the Academity api
  /// endpoint. e.g. if [path] is ['login'], the request is made to
  /// ['http://academityHost/api/login'].
  static Future<http.Response> get(String path,
      [Map<String, dynamic>? queryParameters]) {
    return http.get(Uri.http(academityHost, '/api/$path', queryParameters));
  }

  /// Perform an HTTP POST request to the Academity Api.
  ///
  /// Performs an api request to [path] prefixed with the Academity api
  /// endpoint. e.g. if [path] is ['login'], the request is made to
  /// ['http://academityHost/api/login'].
  static Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    // TODO : add access token in headers
    return http.post(
      Uri.http(academityHost, '/api/$path'),
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }
}
