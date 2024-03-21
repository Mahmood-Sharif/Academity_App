import 'class.dart'; // Import your Class model

class Academy {
  final int academyId;
  final String location;
  final String name;
  final String phone;
  final String description;
  String imageUrl;
  final List<Classes>? classes; // Add a list of Class objects

  Academy({
    required this.academyId,
    required this.location,
    required this.name,
    required this.phone,
    required this.description,
    required this.imageUrl,
    this.classes, // Add classes to the constructor
  });

  factory Academy.fromJson(Map<String, dynamic> json) {
    // Parse the 'classes' JSON array into a list of Class objects
 List<Classes> classesList = [];
    // Check if 'classes' is not null and is a list
    if (json['classes'] != null && json['classes'] is List) {
      // Safely cast json['classes'] to List<dynamic> and parse each element to Classes
      classesList = (json['classes'] as List).map((classJson) {
        // Ensure classJson is a Map<String, dynamic> before parsing
        if (classJson is Map<String, dynamic>) {
          return Classes.fromJson(classJson);
        } else {
          throw Exception("Expected classJson to be of type Map<String, dynamic>");
        }
      }).toList();
    }


    return Academy(
      academyId: json['academy_id'],
      location: json['location'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      imageUrl: json['image_url'],
      classes: classesList,
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
