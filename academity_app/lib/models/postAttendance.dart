class PostAttendance {
  final int studentId;
  final String dateTime;
  final String status;

  PostAttendance({
    required this.studentId,
    required this.dateTime,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'date_time': dateTime,
      'status': status,
    };
  }
}