import 'package:academity_app/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'User Profile',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildDetailCard('Email', 'user@example.com'),
            _buildDetailCard('Phone', '+123456789'),
            _buildDetailCard('Password', '**********'),
            _buildDetailCard('Date of Birth', '01-01-1990'),
            _buildDetailCard('Medical Condition', 'None'),
          ]
              .map((card) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: card,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Card(
      elevation: 4,
      shadowColor: const Color(0xFF008B8B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF008B8B),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        leading: const Icon(
          Icons.info_outline,
          color: Color(0xFFFF3200),
        ),
      ),
    );
  }
}
