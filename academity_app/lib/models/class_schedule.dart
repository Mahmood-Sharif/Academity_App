class ClassSchedule {
  final String date;
  final String startTime;
  final String endTime;
  final String className;
  final String academyName;
  final String location;

  ClassSchedule({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.className,
    required this.academyName,
    required this.location,
  });

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      className: json['class_name'],
      academyName: json['academy_name'],
      location: json['location'],
    );
  }
}
