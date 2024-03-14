// lib/views/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/views/Profile/widgets/section_card.dart';
import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context, WidgetRef ref) {
    ref.read(authStateProvider.notifier).logout().then((_) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $error'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            const SectionCard(
              title: 'Account',
              items: [
                {'title': 'Profile', 'icon': Icons.person},
                {'title': 'Privacy and Security', 'icon': Icons.lock},
              ],
            ),
            const SectionCard(
              title: 'Support & About',
              items: [
                {'title': 'My Subscriptions', 'icon': Icons.subscriptions},
              ],
            ),
            SectionCard(
              title: 'Actions',
              items: [
                const {
                  'title': 'Report A Problem',
                  'icon': Icons.report_problem
                },
                {
                  'title': 'Logout',
                  'icon': Icons.logout,
                  'onTap': () => _logout(context, ref), // Updated logout call
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}
