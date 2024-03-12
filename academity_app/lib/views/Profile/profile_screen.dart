// lib/views/profile/profile_page.dart
import 'package:academity_app/views/Profile/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/views/widgets/app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: const <Widget>[
            SectionCard(
              title: 'Account',
              items: [
                {'title': 'Profile', 'icon': Icons.person},
                {'title': 'Players', 'icon': Icons.group},
                {'title': 'Privacy and Security', 'icon': Icons.lock},
              ],
            ),
            SectionCard(
              title: 'Support & About',
              items: [
                {'title': 'My Subscriptions', 'icon': Icons.subscriptions},
                {'title': 'Terms and Policies', 'icon': Icons.policy},
                {'title': 'Help & Support', 'icon': Icons.help_outline},
              ],
            ),
            SectionCard(
              title: 'Actions',
              items: [
                {'title': 'Report A Problem', 'icon': Icons.report_problem},
                {'title': 'Logout', 'icon': Icons.logout},
              ],
            ),
          ],
        ),
      ),
    );
  }
}
