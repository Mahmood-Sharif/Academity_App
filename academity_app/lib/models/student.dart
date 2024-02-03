class Student {
  final int userId;
  final int age;
  final String dob;
  final int emergencyContact;
  final String firstName;
  final String gender;
  final String lastName;
  final String medicalCondition;
  final int phone;

  Student({
    required this.userId,
    required this.age,
    required this.dob,
    required this.emergencyContact,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.medicalCondition,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'age': age,
        'dob': dob,
        'emergency_contact': emergencyContact,
        'first_name': firstName,
        'gender': gender,
        'last_name': lastName,
        'medical_condition': medicalCondition,
        'phone': phone,
      };
}
