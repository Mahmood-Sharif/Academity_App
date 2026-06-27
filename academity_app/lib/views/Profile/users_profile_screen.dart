import 'dart:async';

import 'package:academity_app/models/users.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:academity_app/views/Profile/widgets/user_profile.dart';
import 'package:academity_app/views/utils/adaptive_padding.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:academity_app/views/widgets/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.userProfileTitle,
        subtitle: 'Personal details',
      ),
      body: AdaptivePadding(
        child: FutureBuilder<User>(
          future: AuthServices.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoadingState(label: 'Loading profile');
            }
            if (snapshot.hasError) {
              final error = snapshot.error!;
              if (error.runtimeType == TimeoutException) {
                return const AppEmptyState(
                  icon: Icons.wifi_off_rounded,
                  title: 'Connection timeout',
                  body: 'Please check your connection and try again.',
                );
              }
              return AppErrorState(error: error);
            }
            if (snapshot.hasData) {
              return UserProfileWidget(user: snapshot.requireData);
            }
            return AppEmptyState(
              icon: Icons.person_off_outlined,
              title: AppLocalizations.of(context)!.noUserDataFound,
              body: 'Profile information could not be loaded.',
            );
          },
        ),
      ),
    );
  }
}
