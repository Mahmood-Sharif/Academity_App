import 'package:academity_app/design/app_theme.dart';
import 'package:academity_app/providers/auth_provider.dart';
import 'package:academity_app/views/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/l10n/app_localizations.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: _LoginScreenBody(),
    );
  }
}

class _LoginScreenBody extends StatefulWidget {
  const _LoginScreenBody();

  @override
  State<_LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return _AuthBackdrop(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 860;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1040),
                  child: isWide
                      ? Row(
                          children: [
                            const Expanded(child: _AuthHero()),
                            const SizedBox(width: AppSpacing.xl),
                            SizedBox(
                              width: 420,
                              child: _LoginForm(
                                emailController: emailController,
                                passwordController: passwordController,
                                isLoading: _isLoading,
                                obscurePassword: _obscurePassword,
                                onTogglePassword: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                onSubmit: () => _login(
                                  context,
                                  ref,
                                  emailController.text,
                                  passwordController.text,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _AuthHero(compact: true),
                            const SizedBox(height: AppSpacing.lg),
                            _LoginForm(
                              emailController: emailController,
                              passwordController: passwordController,
                              isLoading: _isLoading,
                              obscurePassword: _obscurePassword,
                              onTogglePassword: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              onSubmit: () => _login(
                                context,
                                ref,
                                emailController.text,
                                passwordController.text,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _login(
    BuildContext context,
    WidgetRef ref,
    String email,
    String password,
  ) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(authProvider.notifier).login(email.trim(), password);
      if (!context.mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

class _LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;

  const _LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign in',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Use your Academity account to continue.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.muted,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.emailLabel,
              prefixIcon: const Icon(Icons.alternate_email_rounded),
            ),
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.passwordLabel,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                visualDensity: VisualDensity.compact,
                splashRadius: 18,
                onPressed: onTogglePassword,
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
            autofillHints: const [AutofillHints.password],
            obscureText: obscurePassword,
            onSubmitted: (_) => onSubmit(),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: isLoading ? null : onSubmit,
            child: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(AppLocalizations.of(context)!.loginButton),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed('/signup'),
            child: Text(AppLocalizations.of(context)!.signUpButton),
          ),
        ],
      ),
    );
  }
}

class _AuthHero extends StatelessWidget {
  final bool compact;

  const _AuthHero({this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
              child: Image.asset('lib/assets/images/logo_L.png'),
            ),
            const SizedBox(width: 12),
            Text(
              'Academity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
        SizedBox(height: compact ? 28 : 48),
        Text(
          'Welcome back',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.navy,
                fontWeight: FontWeight.w900,
                height: 1.02,
              ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            'Sign in to manage your academy journey, class schedule, enrollments, and attendance.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.muted,
                  height: 1.45,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        if (!compact) ...[
          const SizedBox(height: 30),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _HeroPill(icon: Icons.calendar_month_rounded, label: 'Schedule'),
              _HeroPill(icon: Icons.school_rounded, label: 'Academies'),
              _HeroPill(icon: Icons.qr_code_rounded, label: 'QR attendance'),
            ],
          ),
        ],
      ],
    );
  }
}

class _HeroPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: AppColors.brand),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.slate,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthBackdrop extends StatelessWidget {
  final Widget child;

  const _AuthBackdrop({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Positioned(
          left: -120,
          bottom: -130,
          child: _SoftCircle(
            size: 320,
            color: AppColors.coral.withValues(alpha: .08),
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
                child: child,
              ),
            ],
          ),
        ),
      ],
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
