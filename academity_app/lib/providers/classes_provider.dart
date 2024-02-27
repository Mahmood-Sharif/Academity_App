import 'dart:convert';

import 'package:academity_app/models/class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final classes_provider = FutureProvider<List<Classes>>((ref) async {
 final response= await http.get(Uri.http("http://192.168.100.15:8080/api/classes"));
 final (classes: List<Map<String, dynamic>> classes) = jsonDecode(response.body);
 return  classes.map(Classes.fromJson).toList();
});