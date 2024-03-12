class Student {
  final int studentId;
  final DateTime dob;
  final int? phone;
  final int? emergencyContact;
  final String firstName;
  final String lastName;
  final String gender;
  final String? medicalCondition;
  final String enrollmentId; // new field
  final DateTime? startDate; // new field
  final DateTime? endDate; // new field
  final String classId; // new field

  Student({
    required this.studentId,
    required this.dob,
     this.phone,
     this.emergencyContact,
    required this.firstName,
    required this.lastName,
    required this.gender,
     this.medicalCondition,
    required this.enrollmentId,
     this.startDate,
     this.endDate,
    required this.classId,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['student_id'],
      dob: DateTime.parse(json['dob']['date']),
      phone: json['phone'],
      emergencyContact: json['emergency_contact'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      medicalCondition: json['medical_condition'],
      enrollmentId: json['enrollment_id'], // map new fields
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      classId: json['class_id'],
    );
  }
}
