class ClassTiming {
  final int timingId;
  final int classId;
  final String dayOfWeek;
  final DateTime startTime;
  final DateTime endTime;

  ClassTiming({
    required this.timingId,
    required this.classId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory ClassTiming.fromJson(Map<String, dynamic> json) {
    return ClassTiming(
      timingId: json['timing_id'] as int,
      classId: json['class_id'] as int,
      dayOfWeek: json['day_of_week'] as String,
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
    );
  }

  Map<String, dynamic> toJson() => {
        'timing_id': classId,
        'class_id': classId,
        'day_of_week': dayOfWeek,
        'start_time': startTime.toString(),
        'end_time': endTime.toString(),
      };
}
