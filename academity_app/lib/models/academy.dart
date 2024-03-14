import 'dart:core';

import 'class.dart'; // Import your Class model

class Academy {
  final int academyId;
  final String location;
  final String name;
  final String phone;
  final String description;
  String? imageUrl;
  final List<Classes> classes; // Add a list of Class objects
  final String mediaId;
  final String ownerId;

  Academy({
    required this.academyId,
    required this.location,
    required this.name,
    required this.phone,
    required this.description,
     this.imageUrl,
    required this.classes, // Add classes to the constructor
    required this.mediaId,
    required this.ownerId,
  });

  factory Academy.fromJson(Map<String, dynamic> json) {
    // Parse the 'classes' JSON array into a list of Class objects
    List<Classes> classesList = [];
    if (json['classes'] != null) {
      classesList = (json['classes'])
          .map((classJson) => Classes.fromJson(classJson))
          .toList();
    }

    return Academy(
      academyId: json['academy_id'],
      location: json['location'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      imageUrl: json['image_url'],
      classes: classesList, mediaId: '', ownerId: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'academy_id': academyId,
      'location': location,
      'name': name,
      'phone': phone,
      'description': description,
      'image_url': imageUrl,
      // 'classes': classes.map((c) => c.toJson()).toList(),
    };
  }
}
    
