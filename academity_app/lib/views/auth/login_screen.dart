import 'package:academity_app/main.dart';
import 'package:academity_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                    autofillHints: const [AutofillHints.email],

                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: UnderlineInputBorder(),
                    ),
                    autofillHints: const [AutofillHints.password],
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
          ],
        );
      },
    );
  }

  Future<void> _login(BuildContext context, WidgetRef ref, String email,
      String password) async {
    final result = await AuthServices().login(email, password);

    if (result) {
      ref.invalidate(isLoggedInProvider);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/browseSports', (route) => false); // Adjust this route as needed
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login failed')));
    }
  }
}
