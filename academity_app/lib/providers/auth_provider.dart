import 'dart:async';

import 'package:academity_app/models/users.dart';
import 'package:academity_app/providers/academy_provider.dart';
import 'package:academity_app/providers/class_provider.dart';
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
    final user = await AuthServices.login(email, password)
        .timeout(const Duration(seconds: 10));
    if (user.type == 'coach') canSwitchType = true;
    state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    try {
      await AuthServices.logout();
    } catch (_) {}
    state = const AsyncValue.data(null);
    canSwitchType = false;
    // invalidate user specific data
    ref.invalidate(enrolledAcademiesProvider);
    ref.invalidate(scheduleForStudentProvider);
    ref.invalidate(scheduleForCoachProvider);
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

  Future<void> uploadProfilePicture(String filePath) async {
    try {
      await AuthServices.uploadProfilePicture(filePath);
      // You might want to update the user object after the profile picture is uploaded
      final updatedUser = await AuthServices.getUserProfile();
      state = AsyncValue.data(updatedUser);
    } catch (e) {
      // Handle errors
      throw Exception('An error occurred while uploading profile picture: $e');
    }
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});
