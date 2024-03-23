class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final DateTime dob;
  final String gender;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'], // Ensure this matches the JSON structure
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      dob: DateTime.parse(json['user']['dob']['date']),
      gender: json['user']['gender'],
    );
  }
}
