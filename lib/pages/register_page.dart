import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/input_field.dart';
import '../widgets/primary_button.dart';
import '../controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();

  final registerController = Get.find<RegisterController>();

  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
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

               
                InputField(
                  controller: txtUsername,
                  label: "Username",
                  hintText: "Enter your username",
                ),
                const SizedBox(height: 20),

                
                Obx(
                  () => InputField(
                    controller: txtPassword,
                    label: "Password",
                    hintText: "Enter your password",
                    isPassword: true,
                    obscureText: isPasswordHidden.value,
                    onVisibilityToggle: () {
                      isPasswordHidden.value = !isPasswordHidden.value;
                    },
                  ),
                ),
                const SizedBox(height: 20),

               
                Obx(
                  () => InputField(
                    controller: txtConfirmPassword,
                    label: "Confirm Password",
                    hintText: "Re-enter your password",
                    isPassword: true,
                    obscureText: isConfirmPasswordHidden.value,
                    onVisibilityToggle: () {
                      isConfirmPasswordHidden.value =
                          !isConfirmPasswordHidden.value;
                    },
                  ),
                ),
                const SizedBox(height: 32),

                
                PrimaryButton(
                  text: "Sign Up",
                  onPressed: () {
                    registerController.register(
                      txtUsername.text.trim(),
                      txtPassword.text,
                      txtConfirmPassword.text,
                    );
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
                    onPressed: () => Get.offAllNamed('/login'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      "Sign In",
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

  @override
  void dispose() {
    txtUsername.dispose();
    txtPassword.dispose();
    txtConfirmPassword.dispose();
    super.dispose();
  }
}
