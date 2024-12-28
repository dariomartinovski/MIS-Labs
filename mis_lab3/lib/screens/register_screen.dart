import 'package:flutter/material.dart';
import 'package:mis_lab2/services/AuthService.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  RegisterScreen({super.key});

  void registerUser(BuildContext context) {
    _authService.registerUser(context, emailController.text, passwordController.text).then((_) {
      Navigator.pop(context); // Go back to the login screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => registerUser(context),
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
