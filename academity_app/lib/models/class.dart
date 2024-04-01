import 'package:intl/intl.dart';

class Classes {
  final int classId;
  final String className;
  final int minAge;
  final int maxAge;
  final DateTime? startDate;
  final DateTime? endDate;
  final int academyId;
  final String price;
  final List<ClassTiming> timings;

  Classes({
    required this.classId,
    required this.className,
    required this.minAge,
    required this.maxAge,
    required this.academyId,
    required this.price,
    required this.timings,
    this.startDate,
    this.endDate,
  });

  factory Classes.fromJson(Map<String, dynamic> json) {
    final String price = json['price'] ?? 'Price Unavailable';
    List<ClassTiming> timings = [];
    if (json['timings'] != null) {
      var timingsJson = json['timings'] as List<dynamic>;
      timings = timingsJson
          .map((i) => ClassTiming.fromJson(i as Map<String, dynamic>))
          .toList();
    }

    DateTime? parsedStartDate;
    DateTime? parsedEndDate;
    if (json['start_date'] != null) {
      parsedStartDate = DateTime.tryParse(json['start_date']);
    }
    if (json['end_date'] != null) {
      parsedEndDate = DateTime.tryParse(json['end_date']);
    }

    return Classes(
      classId: json['class_id'],
      className: json['class_name'],
      minAge: json['min_age'],
      maxAge: json['max_age'],
      academyId: json['academy_id'],
      price: price,
      timings: timings,
      startDate: parsedStartDate,
      endDate: parsedEndDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'class_id': classId,
      'class_name': className,
      'min_age': minAge,
      'max_age': maxAge,
      'academy_id': academyId,
      'price': price,
      'start_date': startDate != null
          ? DateFormat('yyyy-MM-dd').format(startDate!)
          : null,
      'end_date':
          endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : null,
      'timings': timings.map((timing) => timing.toJson()).toList(),
    };
  }

  // Method to get formatted start date
  String getFormattedStartDate() {
    if (startDate != null) {
      return DateFormat('dd-MM-yyyy').format(startDate!);
    } else {
      return 'Not available';
    }
  }

  // Method to get formatted end date
  String getFormattedEndDate() {
    if (endDate != null) {
      return DateFormat('dd-MM-yyyy').format(endDate!);
    } else {
      return 'Not available';
    }
  }
}

class ClassTiming {
  final int timingId;
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
