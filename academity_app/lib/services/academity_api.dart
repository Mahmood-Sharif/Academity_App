import 'dart:convert';

import 'package:academity_app/env.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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

    return http.get(
        Uri.parse('${Env.academityUrl}api/$path')
            .replace(queryParameters: queryParameters),
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
      Uri.parse('${Env.academityUrl}api/$path'),
      headers: mergedHeaders,
      body: body,
      encoding: encoding,
    );
  }

  /// Perform an HTTP POST request to the Academity Api.
  ///
  /// Like [AcademityApi.post], except it can also upload a [file].
  ///
  /// If thei api token does not exist, a blank streamed response with code 401
  /// is returned.
  static Future<http.StreamedResponse> postMultipart(
    String path, {
    http.MultipartFile? file,
    Map<String, String>? body,
    Encoding? encoding,
    Map<String, String>? headers,
  }) async {
    const secureStorage = FlutterSecureStorage();
    final apiToken = await secureStorage.read(key: 'api_token');
    if (apiToken == null) {
      return http.StreamedResponse(const Stream.empty(), 401);
    }

    final request = http.MultipartRequest(
        'POST', Uri.parse('${Env.academityUrl}api/$path'));

    request.headers.addAll({'Authorization': 'Bearer $apiToken'});
    if (body != null) {
      request.fields.addAll(body);
    }
    if (file != null) {
      request.files.add(file);
    }

    return request.send();
  }
}
