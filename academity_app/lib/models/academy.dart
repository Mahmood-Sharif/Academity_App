class Academy {
  final int academyId;
  final String location;
  final String name;
  final String phone;
  final String description;
  final String mediaId;
  final String ownerId;

  Academy({
    required this.academyId,
    required this.location,
    required this.name,
    required this.phone,
    required this.description,
    required this.mediaId,
    required this.ownerId,
  });

  factory Academy.fromJson(Map<String, dynamic> json) {
    return Academy(
      academyId: json['academy_id'] as int, 
      location: json['location'].toString(),
      name: json['name'].toString(),
      phone: json['phone'].toString(),
      description: json['description'].toString(),
      mediaId: json['media_id'].toString(),
      ownerId: json['owner_id'].toString(),
    );
  }
}