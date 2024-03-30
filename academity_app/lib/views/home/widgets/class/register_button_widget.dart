import 'package:academity_app/services/academy_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Center(
            child: ElevatedButton(
              onPressed: () => _showReferralCodeDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3200), // Button background color
                padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 10), // Makes the button a bit bigger
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // Slightly rounded edges
                ),
              ),
              child: const Text('Register', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        );
      },
    );
  }

  void _showReferralCodeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController controller = TextEditingController();
      return AlertDialog(
        title: const Text('Enter Referral Code'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Referral Code',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text('Submit'),
            onPressed: () async {
              final success = await AcademyServices().enrollStudentWithCode(controller.text);
              Navigator.of(context).pop(); // Close the dialog
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Successfully enrolled with code ${controller.text}')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enrollment failed. Please check the code and try again.')),
                );
              }
            },
          ),
        ],
      );
    },
  );
}

}
