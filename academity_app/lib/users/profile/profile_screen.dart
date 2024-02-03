import 'package:academity_app/auth/login.dart';
import 'package:academity_app/users/profile/registration_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Adjust the import path according to your project structure

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _logout() async {
    // Clear user data from shared preferences or any other local storage
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_email'); // Adjust according to what you store

    // Optionally, call a logout API if you have server-side actions
    // ApiService().logoutUser();

    // Redirect to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Registration Form'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RegistrationFormScreen()));
          },
        ),
      ),
    );
  }
}
