class ClassTiming {
  final String timingId;
  final int classId;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  

  ClassTiming({
    required this.timingId,
    required this.classId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory ClassTiming.fromJson(Map<String, dynamic> json) {
    return ClassTiming(
      timingId: json['timing_id'],
      classId: json['class_id'],
      dayOfWeek: json['day_of_week'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'timing_id': timingId,
        'class_id': classId,
        'day_of_week': dayOfWeek,
        'start_time': startTime,
        'end_time': endTime,
      };
}
