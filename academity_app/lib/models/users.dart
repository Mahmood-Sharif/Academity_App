import 'package:flutter/foundation.dart';

@immutable
class User {
  final int id;
  final String name;
  final String? email; // email can be null (child account)
  final String phone;
  final DateTime dob;
  final String gender;
  final String type;
  final String? image; // Add the image property

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.type,
    this.image, // Update the constructor
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      type: json['type'] ?? 'user',
      image: json['profile_image_url'] , // Parse the image property from JSON
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
      'profile_image_url': image, // Include the image property in JSON
    };
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    DateTime? dob,
    String? gender,
    String? type,
    String? image, // Add image to the copyWith method
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      type: type ?? this.type,
      image: image ?? this.image, // Update the image property
    );
  }
}
