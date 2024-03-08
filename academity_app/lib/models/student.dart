class Student {
  final int studentId;
  final DateTime dob;
  final int phone;
  final int emergencyContact;
  final String firstName;
  final String lastName;
  final String gender;
  final String medicalCondition;

  Student({
    required this.studentId,
    required this.dob,
    required this.phone,
    required this.emergencyContact,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.medicalCondition,
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
    );
  }
}