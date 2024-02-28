import 'dart:convert';

import 'package:academity_app/models/class.dart';
import 'package:academity_app/models/class_timing.dart';
import 'package:academity_app/services/academity_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final classes_provider = FutureProvider<List<ClassTiming>>((ref) async {
 final response= await  AcademityApi.get('classes');
 final (classes: List<Map<String, dynamic>> classes) = jsonDecode(response.body);
 return  classes.map(ClassTiming.fromJson).toList();
});