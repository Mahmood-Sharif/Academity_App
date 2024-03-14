class ClassWithTiming {
  final int classId;
  final String className;
  final int minAge;
  final int maxAge;
  final int academyId;
  final String? dayOfWeek;
  final String? startTime;
  final String? endTime;
  final String? name;

  ClassWithTiming({
    required this.classId,
    required this.className,
    required this.minAge,
    required this.maxAge,
    required this.academyId,
    this.dayOfWeek,
    this.startTime,
    this.endTime,
    this.name,
  });

  factory ClassWithTiming.fromJson(Map<String, dynamic> json) {
    return ClassWithTiming(
      classId: json['class_id'] as int,
      className: json['class_name'] as String,
      minAge: json['min_age'] as int,
      maxAge: json['max_age'] as int,
      academyId: json['academy_id'] as int,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      dayOfWeek: json['day_of_week'] as String?,
      name: json['name'] as String?,
    );
  }
}
