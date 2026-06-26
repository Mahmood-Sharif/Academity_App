import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/views/auth/widgets/signup_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFFFFBF8),
                    const Color(0xFFFF3200).withValues(alpha: .08),
                    const Color(0xFF008B8B).withValues(alpha: .12),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: .06,
              child: Image.asset('lib/assets/images/logo_L.png', width: 240),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 22, 14, 22),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'lib/assets/images/MainLogo.jpg',
                            height: 76,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!.createYourAccount,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 6),
                          const SignupForm(),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              text: AppLocalizations.of(
                                context,
                              )!
                                  .alreadyHaveAnAccount,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: AppLocalizations.of(
                                    context,
                                  )!
                                      .loginButton,
                                  style: GoogleFonts.montserrat(
                                    decoration: TextDecoration.underline,
                                    color: const Color(0xFF008B8B),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
