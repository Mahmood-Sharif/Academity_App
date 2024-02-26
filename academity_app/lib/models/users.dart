class User {
  final int userId;
  final String email;

  User({required this.userId, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    // Use toString() to handle non-String types and null values safely
    final userId = json['user_id'];
    // Use null-aware operator to provide a fallback for potential null values
    final email = json['email'];

    return User(
      userId: userId,
      email: email,
    );
  }
}
