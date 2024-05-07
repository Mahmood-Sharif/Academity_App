import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'lib/assets/images/pattern.jpg',
                scale: 1.0,
                width: 380,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Main Logo Image
                    Image.asset('lib/assets/images/MainLogo.jpg', width: 350),
                    const SizedBox(height: 100),

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
                          borderRadius: BorderRadius.circular(
                              4), // Slightly rounded edges
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)!.loginButton,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF008B8B), // Button background color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 82, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)!.signUpButton,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
