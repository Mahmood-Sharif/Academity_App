import 'class.dart'; // Import your Class model

class Academy {
  final String academyId;
  final String location;
  final String name;
  final String phone;
  final String description;
  final List<Class> classes; // Add a list of Class objects

  Academy({
    required this.academyId,
    required this.location,
    required this.name,
    required this.phone,
    required this.description,
    required this.classes, // Add classes to the constructor
  });

  factory Academy.fromJson(Map<String, dynamic> json) {
    // Parse the 'classes' JSON array into a list of Class objects
    List<Class> classesList = [];
    if (json['classes'] != null) {
      classesList = (json['classes'] as List)
          .map((classJson) => Class.fromJson(classJson))
          .toList();
    }

    return Academy(
      academyId: json['academy_id'],
      location: json['location'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
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
      'classes': classes.map((c) => c.toJson()).toList(),
    };
  }
}
