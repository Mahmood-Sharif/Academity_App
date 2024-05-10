// lib/views/profile/user_profile_screen.dart
import 'dart:async';

import 'package:academity_app/views/Profile/widgets/user_profile.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/models/users.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.userProfileTitle,
      ),
      body: AdaptivePadding(
        child: FutureBuilder<User>(
          future: AuthServices.getUserProfile(), // Implement this method
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              final error = snapshot.error!;
              if (error.runtimeType == TimeoutException) {
                return const Center(child: Text('Connection Timeout'));
              } else {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
            } else if (snapshot.hasData) {
              return UserProfileWidget(user: snapshot.data!);
            } else {
              return Center(
                  child: Text(AppLocalizations.of(context)!.noUserDataFound));
            }
          },
        ),
      ),
    );
  }
}
