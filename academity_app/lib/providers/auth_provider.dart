  import 'package:academity_app/models/users.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileProvider = FutureProvider<User>((ref) async {
  return AuthServices().getUserProfile(); // Your method to fetch the user profile
});