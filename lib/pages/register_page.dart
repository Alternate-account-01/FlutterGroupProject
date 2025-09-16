import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RegisterController controller = Get.find<RegisterController>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8A2387), Color(0xFF5A67E8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person_add_alt_1_rounded,
                      color: Color(0xFF6777EF), size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Username
                  InputField(
                    controller: usernameController,
                    label: "Username",
                    hintText: "Enter your username",
                  ),
                  const SizedBox(height: 20),

                  // Password
                  Obx(
                    () => InputField(
                      controller: passwordController,
                      label: "Password",
                      hintText: "Enter your password",
                      isPassword: true,
                      obscureText: controller.isPasswordHidden.value,
                      onVisibilityToggle: () {
                        controller.isPasswordHidden.value =
                            !controller.isPasswordHidden.value;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password
                  Obx(
                    () => InputField(
                      controller: confirmPasswordController,
                      label: "Confirm Password",
                      hintText: "Re-enter your password",
                      isPassword: true,
                      obscureText: controller.isConfirmPasswordHidden.value,
                      onVisibilityToggle: () {
                        controller.isConfirmPasswordHidden.value =
                            !controller.isConfirmPasswordHidden.value;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Register Button
                  PrimaryButton(
                    text: "Sign Up",
                    onPressed: () {
                      controller.register(
                        usernameController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Back to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed('/login');
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xFF6777EF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}