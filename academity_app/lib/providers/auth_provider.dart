import 'package:academity_app/models/users.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<User?> {
  final Ref ref;

  AuthNotifier(this.ref) : super(null);

  Future<bool> login(String email, String password) async {
    final user = await ref.read(authServicesProvider).login(email, password);
    if (user != null) {
      state = user;
      return true;
    }
    return false;
  }

  void logout() {
    state = null;
    ref.read(authServicesProvider).logout();
  }
}
