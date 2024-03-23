import 'package:flutter/material.dart';
import 'package:academity_app/models/users.dart';

class UserProfileWidget extends StatelessWidget {
  final User user;

  const UserProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a specific color
    const Color customColor = Color(0xFF008B8B); // Example color

    return Form(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildUserInputField(context, 'Name', user.name, Icons.person, customColor),
            _buildUserInputField(context, 'Email', user.email, Icons.email, customColor),
            _buildUserInputField(context, 'Phone', user.phone, Icons.phone, customColor),
            _buildUserInputField(context, 'Date of Birth', _formatDate(user.dob), Icons.cake, customColor),
            _buildUserInputField(context, 'Gender', user.gender, Icons.male, customColor),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInputField(BuildContext context, String label, String initialValue, IconData icon, Color customColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: customColor), // Use the custom color for label text
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon, color: customColor), // Use the custom color for icon
        ),
        readOnly: true, // Set to false when implementing the edit feature
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Formatting date as yyyy-MM-dd
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
