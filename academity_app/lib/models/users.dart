import 'package:flutter/foundation.dart';

@immutable
class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final DateTime dob;
  final String gender;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // Ensure this matches the JSON structure
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
    );
  }
}
