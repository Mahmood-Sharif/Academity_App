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

    // Attempt to parse 'id' and log the outcome
    final idParsed = json['id'];
    print('Parsed id: $idParsed');
    if (idParsed == null) {
      throw FormatException("Invalid format for 'id': ${json['id']}");
    }

    // Continue with parsing, adding print statements as necessary
    final name = json['name'];
    print('Parsed name: $name');

    final email = json['email'];
    print('Parsed email: $email');

    final phone = json['phone'];
    print('Parsed phone: $phone');

    // Parsing DateTime can also be a common source of errors
    DateTime dob;
    try {
      dob = DateTime.parse(json['dob']);
      print('Parsed dob: $dob');
    } catch (e) {
      print('Error parsing dob: ${json['dob']}, Exception: $e');
      rethrow; // or handle the error as appropriate
    }

    final gender = json['gender'];
    print('Parsed gender: $gender');

    // If everything went well, return the constructed User
    return User(
      id: idParsed,
      name: name,
      email: email,
      phone: phone,
      dob: dob,
      gender: gender,
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
