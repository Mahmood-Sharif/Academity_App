import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/views/auth/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF7FAFC),
                    Color(0xFFEAF6F7),
                    Color(0xFFF8FAFC),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -90,
            top: -90,
            child: _SoftCircle(
              size: 260,
              color: AppColors.teal.withValues(alpha: .10),
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: AppColors.navy,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 72, 22, 28),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: AppShadows.tight,
                                ),
                                child: Image.asset(
                                  'lib/assets/images/logo_L.png',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Academity',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppColors.navy,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          Text(
                            AppLocalizations.of(context)!.createYourAccount,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: AppColors.navy,
                                  fontWeight: FontWeight.w900,
                                  height: 1.05,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Create your profile to browse academies and manage class enrollments.',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.muted,
                                      height: 1.45,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(height: 22),
                          const SignupForm(),
                          const SizedBox(height: 16),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/login');
                              },
                              child: Text(
                                '${AppLocalizations.of(context)!.alreadyHaveAnAccount} ${AppLocalizations.of(context)!.loginButton}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _SoftCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
