import 'package:academity_app/models/users.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/services/auth_services.dart';

final authServicesProvider = Provider<AuthServices>((ref) => AuthServices());

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  // Note the change here from read to ref
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<User?> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(null);

  Future<bool> login(String email, String password) async {
    try {
      // Changes here: _ref.read to access the provider
      final bool success = await _ref.read(authServicesProvider).login(email, password);
      if (success) {
        // Implement the actual logic to fetch user details
        final User user = await getUserDetails(email);
        state = user;
        return true;
      }
    } catch (e) {
      Exception(e);
    }
    return false;
  }

  // Your method to fetch user details would be here
  Future<User> getUserDetails(String email) async {
    // Placeholder implementation
    return User(userId: 1, email: email);
  }

  void logout() async {
    await _ref.read(authServicesProvider).logout();
    state = null;
  }
}
