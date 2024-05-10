import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/views/auth/widgets/signup_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Making the Scaffold's body a Stack to overlay the image over the form.
    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFF3200)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.createYourAccount,
          style: const TextStyle(color: Color(0xFF8B0000)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 180,
              width: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/images/logo1.png"),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SignupForm(),
                  const SizedBox(height: 20),
                  // Combined text and clickable "Sign In"
                  RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.alreadyHaveAnAccount,
                      style: GoogleFonts.montserrat(
                        color: Colors.black, // Default text color
                        fontSize: 16, // Set font size to 18
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!.loginButton,
                          style: GoogleFonts.montserrat(
                            decoration: TextDecoration.underline,
                            color: const Color.fromARGB(
                                255, 0, 139, 139), // Specific color
                            fontSize: 16, // Set font size to 18
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed('/login');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
