class Academy {
  final int academyId;
  final String location;
  final String name;
  final int phone;
  final String description;
  final String imageUrl;
  final int ownerId;

  Academy({
    required this.academyId,
    required this.location,
    required this.name,
    required this.phone,
    required this.description,
    required this.imageUrl,
    required this.ownerId,
  });

  // Factory constructor to create an Academy from a map (e.g., JSON)
  factory Academy.fromJson(Map<String, dynamic> json) {
    return Academy(
      academyId: json['academy_id'],
      location: json['location'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      imageUrl: json['image_url'],
      ownerId: json['owner_id'],
    );
  }

  // Method to convert Academy instance to a map, useful for sending data to the API
  Map<String, dynamic> toJson() => {
    'academy_id': academyId,
    'location': location,
    'name': name,
    'phone': phone,
    'description': description,
    'image_url': imageUrl,
    'owner_id': ownerId,
  };
}
