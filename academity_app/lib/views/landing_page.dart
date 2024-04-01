import 'package:academity_app/main.dart';
import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/views/auth/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return switch (auth) {
      AsyncData(value: null) => const HomeScreen(),
      AsyncData(value: final _) => const MainScreen(),
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
