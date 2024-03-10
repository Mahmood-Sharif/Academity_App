import 'class_timing.dart'; // Ensure this path is correct and points to your ClassTiming model

class Classes {
  final int classId;
  final String className;
  final int minAge;
  final int maxAge;
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
  });

  factory Classes.fromJson(Map<String, dynamic> json) {
    final String price = json['price'] ?? 'Price Unavailable';
    List<ClassTiming> timings = [];
    if (json['timings'] != null) {
      var timingsJson = json['timings'] as List;
      timings = timingsJson.map((i) => ClassTiming.fromJson(i)).toList();
    }

    return Classes(
      classId: json['class_id'],
      className: json['class_name'],
      minAge: json['min_age'],
      maxAge: json['max_age'],
      academyId: json['academy_id'],
      price: price,
      timings: timings,
    );
  }
}
