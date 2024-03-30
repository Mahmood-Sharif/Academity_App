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
  print('Received JSON for User: $json');

  final int idParsed = json['id'];
  if (idParsed == null) {
    throw FormatException("Invalid format for 'id': ${json['id']}");
  }

  final DateTime dob;
  try {
    dob = DateTime.parse(json['dob']);
  } catch (e) {
    print('Error parsing dob: ${json['dob']}, Exception: $e');
    rethrow;
  }

  return User(
    id: idParsed,
    name: json['name'] ?? '', // Fallback to empty string if null
    email: json['email'] ?? '',
    phone: json['phone'].toString(),
    dob: dob,
    gender: json['gender'] ?? '',
  );
}


  Map<String, dynamic> toJson() {
  return {
    'id': id.toString(),
    'name': name,
    'email': email,
    'phone': phone.toString(), // Ensure this is a string
    'dob': dob.toIso8601String(),
    'gender': gender,
  };
}


  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    DateTime? dob,
    String? gender,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
    );
  }
}
