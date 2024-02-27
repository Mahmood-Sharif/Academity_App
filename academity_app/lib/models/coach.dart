class Coach {
  final int coachId;
  final String name;

  Coach({
    required this.coachId,
    required this.name,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      coachId: json['coach_id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'coach_id': coachId,
        'name': name,
      };
}
