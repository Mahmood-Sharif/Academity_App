class Attendance {
  final int? attendanceId;
  final int studentId;
  final String studentName;
  String status;
  final int classId;
  bool? isUpdateSuccess;

  Attendance({
    this.attendanceId,
    required this.studentId,
    required this.studentName,
    required this.status,
    required this.classId,
    this.isUpdateSuccess,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
        attendanceId: json['attendance_id'],
        studentId: json['student_id'],
        studentName: json['student_name'],
        status: json['status'],
        classId: json['class_id']);
  }
}
