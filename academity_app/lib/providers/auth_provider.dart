import 'dart:async';

import 'package:academity_app/models/users.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthNotifier extends AsyncNotifier<User?> {
  bool canSwitchType = false;

  @override
  FutureOr<User?> build() async {
    const secureStorage = FlutterSecureStorage();
    final apiToken = await secureStorage.read(key: 'api_token');

    if (apiToken == null) {
      return null;
    } else {
      final user = await AuthServices.loginTest();
      if (user?.type == 'coach') canSwitchType = true;
      return user;
    }
  }

  Future<void> loginTest() async {
    final user = await AuthServices.loginTest();
    if (user?.type == 'coach') canSwitchType = true;
    state = AsyncValue.data(user);
  }

  Future<void> login(String email, String password) async {
    final user = await AuthServices.login(email, password);
    if (user.type == 'coach') canSwitchType = true;
    state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    await AuthServices.logout();
    state = const AsyncValue.data(null);
    canSwitchType = false;
  }

  void changeUserType() {
    final user = state.requireValue;
    if (canSwitchType && user != null) {
      final oppositeType = switch (user.type) {
        'user' => 'coach',
        'coach' => 'user',
        _ => throw Exception('invalid user type'),
      };
      state = AsyncValue.data(user.copyWith(type: oppositeType));
    }
  }

  Future<bool> updateProfile(User user) async {
    return await AuthServices.editUserProfile(user).then((newUser) {
      state = AsyncValue.data(newUser);
      return true;
    }).catchError((error, stackTrace) => false);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});
