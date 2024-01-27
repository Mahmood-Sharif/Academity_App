class Classes {
  final int classId;
  final String className;
  final String dayOfWeek;
  final String endTime;
  final String instructor;
  final double price;
  final String startTime;
  final int minAge;
  final int maxAge;
  final int academyId;

  Classes({
    required this.classId,
    required this.className,
    required this.dayOfWeek,
    required this.endTime,
    required this.instructor,
    required this.price,
    required this.startTime,
    required this.minAge,
    required this.maxAge,
    required this.academyId,
  });

  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(
      classId: json['class_id'] as int,
      className: json['class_name'] as String,
      dayOfWeek: json['day_of_week'] as String,
      endTime: json['end_time'] as String,
      instructor: json['instructor'] as String,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      startTime: json['start_time'] as String,
      minAge: json['min_age'] as int,
      maxAge: json['max_age'] as int,
      academyId: json['academy_id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'class_id': classId,
        'class_name': className,
        'day_of_week': dayOfWeek,
        'end_time': endTime,
        'instructor': instructor,
        'price': price,
        'start_time': startTime,
        'min_age': minAge,
        'max_age': maxAge,
        'academy_id': academyId,
      };
}
