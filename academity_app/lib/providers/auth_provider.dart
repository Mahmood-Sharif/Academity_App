import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/services/auth_services.dart';

// Define the state notifier for managing authentication state
class AuthStateNotifier extends StateNotifier<bool> {
  final AuthServices authServices;

  AuthStateNotifier(this.authServices)
      : super(false); // Initially, user is not logged in

  Future<void> login(String email, String password) async {
    final success = await authServices.login(email, password);
    state = success; // Update the state based on the login success
  }

  Future<void> register(Map<String, dynamic> data) async {
    final success = await authServices.registerUser(data);
    state = success; // Update the state based on the registration success
  }

  // Add logout method
  Future<void> logout() async {
    await authServices.logout();
    state = false; // Update the state to reflect that the user is logged out
  }
}

// Define a provider for AuthStateNotifier
final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  return AuthStateNotifier(ref.watch(authServicesProvider));
});

// Provide an instance of AuthServices
final authServicesProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});
