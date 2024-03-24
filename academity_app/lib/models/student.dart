class Student {
  final int id;
  final String? username;
  final String? status;
  final String? statusMessage;
  final bool active;
  final String name;
  final String phone;
  final DateTime? dob;
  final String gender;
  final String? medicalCondition;
  final int? parentId;
  final String enrollmentId;
  final String startDate;
  final String endDate;
  final String studentId;
  final String classId;

  Student({
    required this.id,
    required this.username,
    required this.status,
    required this.statusMessage,
    required this.active,
    required this.name,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.medicalCondition,
    required this.parentId,
    required this.enrollmentId,
    required this.startDate,
    required this.endDate,
    required this.studentId,
    required this.classId,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      username: json['username'] as String?,
      status: json['status'] as String?,
      statusMessage: json['status_message'] as String?,
      active: json['active'] as bool,
      name: json['name'] as String,
      phone: json['phone'] as String,
      dob: _parseDateTime(json['dob']['date']),
      gender: json['gender'] as String,
      medicalCondition: json['medical_condition'] as String?,
      parentId: json['parent_id'] as int?,
      enrollmentId: json['enrollment_id'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      studentId: json['student_id'].toString(),
      classId: json['class_id'].toString(),
    );
  }

  static DateTime? _parseDateTime(dynamic dateString) {
    if (dateString == null) return null;
    return DateTime.parse(dateString.toString());
  }
}