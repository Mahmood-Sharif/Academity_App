class Sport {
  final int sportsId;
  final String sportName;
  final String imageUrl;

  Sport(
      {required this.sportsId,
      required this.sportName,
      required this.imageUrl});

  factory Sport.fromJson(Map<String, dynamic> json) {
    return Sport(
      // Parse sport_id to an int
      sportsId: json['sport_id'],
      sportName: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sports_id': sportsId, // Convert back to String if needed
      'sport_name': sportName,
      'image_url': imageUrl,
    };
  }
}
