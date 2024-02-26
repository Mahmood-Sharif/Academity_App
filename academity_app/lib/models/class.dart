class Class {
  final int classId;
  final String className;
  final int minAge;
  final int maxAge;
  final int academyId;

  Class({
    required this.classId,
    required this.className,
    required this.minAge,
    required this.maxAge,
    required this.academyId,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      classId: json['class_id'] as int,
      className: json['class_name'] as String,
      minAge: json['min_age'] as int,
      maxAge: json['max_age'] as int,
      academyId: json['academy_id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'class_id': classId,
        'class_name': className,
        'min_age': minAge,
        'max_age': maxAge,
        'academy_id': academyId,
      };
}
