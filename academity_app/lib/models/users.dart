class User {
  final int userId;
  final String email;

  User({required this.userId, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    final userId = json['user_id'];
    final email = json['email'];

    return User(
      userId: userId,
      email: email,
    );
  }
}
