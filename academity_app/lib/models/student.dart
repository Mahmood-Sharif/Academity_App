import 'package:academity_app/models/users.dart';

class Student extends User {
  final String? medicalCondition;
  final int? parentId;
  final int enrollmentId;
  final String startDate;
  final String endDate;

  const Student({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.dob,
    required super.gender,
    required super.type,
    required this.medicalCondition,
    required this.parentId,
    required this.enrollmentId,
    required this.startDate,
    required this.endDate,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      type: json['type'] ?? 'user',
      medicalCondition: json['medical_condition'],
      parentId: json['parent_id'],
      enrollmentId: json['enrollment_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
    );
  }
}
