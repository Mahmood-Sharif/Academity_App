import 'dart:convert';

import 'package:academity_app/.env.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// TODO: insist on HTTPS
class AcademityApi {
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

    return http.get(Uri.http(Env.academityHost, '/api/$path', queryParameters),
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
    Map<String, String>? headers,
  }) async {
    const secureStorage = FlutterSecureStorage();
    final apiToken = await secureStorage.read(key: 'api_token');
    if (apiToken == null) return http.Response("", 401);

    final mergedHeaders = {'Authorization': 'Bearer $apiToken'};
    if (headers != null) mergedHeaders.addAll(headers);

    return http.post(
      Uri.http(Env.academityHost, '/api/$path'),
      headers: mergedHeaders,
      body: body,
      encoding: encoding,
    );
  }

  /// Perform an HTTP DELETE request to the Academity Api.
  ///
  /// Performs an api request to [path] prefixed with the Academity api
  /// endpoint. e.g. if [path] is ['login'], the request is made to
  /// ['http://academityHost/api/login'].
  ///
  /// If thei api token does not exist, a blank response with code 401 is
  /// returned.
  static Future<http.Response> delete(String path,
      [Map<String, dynamic>? queryParameters]) async {
    const secureStorage = FlutterSecureStorage();
    final apiToken = await secureStorage.read(key: 'api_token');
    if (apiToken == null) return http.Response("", 401);

    return http.delete(
        Uri.http(Env.academityHost, '/api/$path', queryParameters),
        headers: {'Authorization': 'Bearer $apiToken'});
  }
}
