class Academy {
  final int academyId;
  final String location;
  final String name;
  final String phone;
  final String description;
  final String mediaId;
  final String ownerId;
  final String sportId;

  Academy({
    required this.academyId,
    required this.location,
    required this.name,
    required this.phone,
    required this.description,
    required this.mediaId,
    required this.ownerId,
    required this.sportId,
  });

  factory Academy.fromJson(Map<String, dynamic> json) {
    return Academy(
      academyId: json['academy_id'],
      location: json['location'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      mediaId: json['media_id'],
      ownerId: json['owner_id'],
      sportId: json['sport_id'],
    );
  }
}