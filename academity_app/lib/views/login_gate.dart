import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/views/auth/landing_page.dart';
import 'package:academity_app/views/coaches_bottom_navigation.dart';
import 'package:academity_app/views/users_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginGate extends ConsumerWidget {
  const LoginGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return switch (auth) {
      AsyncData(value: null) => const LandingPage(),
      AsyncData(value: final user!) => switch (user.type) {
          'user' => const UsersBottomNavigation(),
          'coach' => const CoachesBottomNavigation(),
          _ => const Center(child: Text('Login Error')),
        },
      AsyncError(:final error, :final stackTrace) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(error.toString()),
                Text(stackTrace.toString()),
              ],
            ),
          ),
        ),
      _ => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
    };
  }
}
