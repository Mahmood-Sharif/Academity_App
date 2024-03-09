import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// TODO: insist on HTTPS
class AcademityApi {
  /// The address of the Academity server
  static const academityHost = '192.168.28.119:8080';
  static const academityUrl = 'http://$academityHost/';

  /// Perform an HTTP GET request to the Academity Api.
  ///
  /// Performs an api request to [path] prefixed with the Academity api
  /// endpoint. e.g. if [path] is ['login'], the request is made to
  /// ['http://academityHost/api/login'].
  ///
  /// If thei api token does not exist, a blank response with code 401 is
  /// returned.
  static Future<http.Response> get(String path,
      [Map<String, dynamic>? queryParameters]) async {
    const secureStorage = FlutterSecureStorage();
    final apiToken = await secureStorage.read(key: 'api_token');
    if (apiToken == null) return http.Response("", 401);

    return http.get(Uri.http(academityHost, '/api/$path', queryParameters),
        headers: {'Authorization': 'Bearer $apiToken'});
  }

  /// Perform an HTTP POST request to the Academity Api.
  ///
  /// Performs an api request to [path] prefixed with the Academity api
  /// endpoint. e.g. if [path] is ['login'], the request is made to
  /// ['http://academityHost/api/login'].
  ///
  /// If thei api token does not exist, a blank response with code 401 is
  /// returned.
  static Future<http.Response> post(
    String path, {
    Object? body,
    Encoding? encoding,
  }) async {
    const secureStorage = FlutterSecureStorage();
    final apiToken = await secureStorage.read(key: 'api_token');
    if (apiToken == null) return http.Response("", 401);

    return http.post(
      Uri.http(academityHost, '/api/$path'),
      headers: {'Authorization': 'Bearer $apiToken'},
      body: body,
      encoding: encoding,
    );
  }
}
