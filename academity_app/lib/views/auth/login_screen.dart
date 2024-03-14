import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:academity_app/providers/auth_provider.dart'; // Make sure this import path is correct

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFF3200)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Enter Your Credentials",
          style: TextStyle(color: Color(0xFF8B0000)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const _LoginScreenBody(),
    );
  }
}

class _LoginScreenBody extends StatefulWidget {
  const _LoginScreenBody({Key? key}) : super(key: key);

  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Using ConsumerWidget to access ref in a StatefulWidget
    return Consumer(
      builder: (context, ref, child) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: UnderlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => _login(context, ref, emailController.text,
                        passwordController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 92, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                'lib/assets/images/logo1.jpg',
                height: 180,
                width: 200,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _login(BuildContext context, WidgetRef ref, String email,
      String password) async {
    await ref.read(authStateProvider.notifier).login(email, password);

    if (ref.read(authStateProvider)) {
      Navigator.of(context)
          .pushReplacementNamed('/'); // Adjust this route as needed
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login failed')));
    }
  }
}
