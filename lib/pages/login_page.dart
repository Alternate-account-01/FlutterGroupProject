import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                const Icon(Icons.check_circle_outline_rounded,
                    color: Color(0xFF6777EF), size: 48),
                const SizedBox(height: 16),
                const Text(
                  "TodoMaster",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Stay organized, stay productive",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 32),
                InputField(
                  controller: emailController,
                  label: "Username",
                  hintText: "Enter your username",
                ),
                const SizedBox(height: 20),
                Obx(
                  () => InputField(
                    controller: passwordController,
                    label: "Password",
                    hintText: "Enter your password",
                    isPassword: true,
                    obscureText: isPasswordHidden.value,
                    onVisibilityToggle: () {
                      isPasswordHidden.value = !isPasswordHidden.value;
                    },
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: "Sign In",
                  onPressed: () {
                    final String username = emailController.text.trim();
                    final String password = passwordController.text;

                    if (username.isEmpty || password.isEmpty) {
                      Get.snackbar(
                        "Input Incomplete",
                        "Username and password cannot be empty.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange.shade600,
                        colorText: Colors.white,
                        icon: const Icon(Icons.warning_amber_rounded,
                            color: Colors.white),
                        margin: const EdgeInsets.all(12),
                        borderRadius: 12,
                      );
                      return;
                    }

                    if (username == 'admin' && password == 'admin') {
                      loginController.isLoggedIn.value = true;
                      Get.offAllNamed('/drawer');
                      Get.snackbar(
                        "Login Successful",
                        "Welcome back, admin!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        icon: const Icon(Icons.check_circle_outline,
                            color: Colors.white),
                        margin: const EdgeInsets.all(12),
                        borderRadius: 12,
                      );
                    } else {
                      Get.snackbar(
                        "Login Failed",
                        "Invalid username or password.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade400,
                        colorText: Colors.white,
                        icon: const Icon(Icons.error_outline_rounded,
                            color: Colors.white),
                        margin: const EdgeInsets.all(12),
                        borderRadius: 12,
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or",
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}