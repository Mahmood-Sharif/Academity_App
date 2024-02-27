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
      sportsId: json['sports_id'],
      sportName: json['sport_name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sports_id': sportsId,
      'sport_name': sportName,
      'image_url': imageUrl,
    };
  }
}
