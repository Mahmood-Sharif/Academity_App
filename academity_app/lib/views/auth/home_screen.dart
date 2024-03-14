import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Allows scrolling when content is larger than the screen
        child: Column(
          children: [
            // Pattern Image - Now at the top of the screen
            Image.asset('lib/assets/images/pattern.jpg'), // Adjusted asset path
            const SizedBox(height: 40), // Adds space between the elements
            // Main Logo Image
            Image.asset('lib/assets/images/MainLogo.jpg'), // Adjusted asset path
            const SizedBox(height: 100), // Adds space between the elements
            
            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3200), // Button background color
                padding: const EdgeInsets.symmetric(horizontal: 92, vertical: 10), // Makes the button a bit bigger
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // Slightly rounded edges
                ),
              ),
              child: const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 20), // Adds space between the elements

            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF008B8B), // Button background color
                padding: const EdgeInsets.symmetric(horizontal: 82, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
  