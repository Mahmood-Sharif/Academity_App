import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Allows scrolling when content is larger than the screen
        child: Column(
          children: [
            // Pattern Image - Now at the top of the screen
            Image.asset('lib/assets/images/pattern.jpg'), // Adjusted asset path
            const SizedBox(height: 40), // Adds space between the elements
            // Main Logo Image
            Image.asset('lib/assets/images/MainLogo.jpg',
                width: 350), // Adjusted asset path
            const SizedBox(height: 100), // Adds space between the elements

            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFFF3200), // Button background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 92,
                    vertical: 10), // Makes the button a bit bigger
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(4), // Slightly rounded edges
                ),
              ),
              child:  Text(AppLocalizations.of(context)!.loginButton,
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 20), // Adds space between the elements

            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF008B8B), // Button background color
                padding:
                    const EdgeInsets.symmetric(horizontal: 82, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.signUpButton,
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
