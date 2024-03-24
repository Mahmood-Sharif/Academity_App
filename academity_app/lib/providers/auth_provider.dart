import 'dart:async';

import 'package:academity_app/models/users.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() async {
    const secureStorage = FlutterSecureStorage();
    final apiToken = await secureStorage.read(key: 'api_token');

    if (apiToken == null) {
      return null;
    } else {
      return await AuthServices.loginTest();
    }
  }

  Future<void> login(String email, String password) async {
    final user = await AuthServices.login(email, password);
    state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    await AuthServices.logout();
    state = const AsyncValue.data(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});
