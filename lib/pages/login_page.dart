import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/InputField.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 100, color: Colors.white),
                const SizedBox(height: 16),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please sign in to continue",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 24),
                InputField(controller: usernameController, hint: "Username", icon: Icons.person),
                const SizedBox(height: 12),
                InputField(controller: passwordController, hint: "Password", obscureText: true, icon: Icons.lock),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: "Login",
                  onPressed: () {
                    loginController.login(
                      usernameController.text,
                      passwordController.text,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
