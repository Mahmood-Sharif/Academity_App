// lib/views/profile/user_profile_screen.dart
import 'package:academity_app/views/Profile/widgets/user_profile.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/users.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "User Profile",
      ),
      body: FutureBuilder<User>(
        future: AuthServices().getUserProfile(), // Implement this method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return UserProfileWidget(user: snapshot.data!);
          } else {
            return const Center(child: Text("No user data found"));
          }
        },
      ),
    );
  }
}
