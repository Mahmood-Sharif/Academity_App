import 'package:academity_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: _LoginScreenBody(ref: ref),
    );
  }
}

// StatefulWidget that uses `ref` passed from the ConsumerWidget
class _LoginScreenBody extends StatefulWidget {
  final WidgetRef ref;

  const _LoginScreenBody({Key? key, required this.ref}) : super(key: key);

  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _login(),
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

Future<void> _login() async {
  // Await the result of the login attempt
  final bool success = await widget.ref.read(authProvider.notifier).login(
    emailController.text,
    passwordController.text,
  );

  if (success) {
    // Debug print
    Navigator.pushReplacementNamed(context, '/browseSports');
  } else {
    print('Login failed'); // Debug print
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login failed')),
    );
  }
}


}
