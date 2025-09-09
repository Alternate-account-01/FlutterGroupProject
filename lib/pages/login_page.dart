import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/InputField.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool _isPasswordVisible = false.obs;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.eco_outlined, color: Colors.green.shade600, size: 36),
                  const SizedBox(width: 8),
                  const Text(
                    "Skibidi",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  "Work without limits",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              InputField(
                controller: usernameController,
                hint: "Your email address",
              ),
              const SizedBox(height: 24),
              Obx(() => InputField(
                    controller: passwordController,
                    hint: "Choose a password",
                    obscureText: !_isPasswordVisible.value,
                    isPassword: true,
                    onVisibilityToggle: (isVisible) {
                      _isPasswordVisible.value = isVisible;
                    },
                  ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: "Continue",
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
    );
  }
}