import 'package:flutter/material.dart';
import 'package:academity_app/services/auth_services.dart';  // Import the AuthServices

class DeletePopUp extends StatefulWidget {
  const DeletePopUp({super.key});

  @override
  _DeletePopUpState createState() => _DeletePopUpState();
}

class _DeletePopUpState extends State<DeletePopUp> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isDeleteEnabled = false;

  void _updateDeleteButtonState() {
    setState(() {
      _isDeleteEnabled = _passwordController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updateDeleteButtonState);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updateDeleteButtonState);
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure you want to delete your account?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Text('By deleting this account, all data associated with the account will be permanently removed. This action cannot be undone.'),
            const SizedBox(height: 16),
            const Text('Data deletion will be effective within 14 days.'),
            const SizedBox(height: 20),
            Container(
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter your password to confirm',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.black87)),
        ),
        TextButton(
          onPressed: _isDeleteEnabled ? () async {
            
          } : null,
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
