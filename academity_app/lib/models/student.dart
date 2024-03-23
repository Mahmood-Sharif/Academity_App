class Student {
  final String studentId;
  final String name;


  Student({
    required this.studentId,
    required this.name,

  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['student_id'],
      name: json['name'],

    );
  }
}