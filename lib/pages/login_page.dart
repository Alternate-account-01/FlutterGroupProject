import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controllers/login_controller.dart';
import '../widgets/primary_button.dart';
import '../widgets/input_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputField(controller: usernameController, hint: "Username"),
            const SizedBox(height: 12),
            InputField(controller: passwordController, hint: "Password", obscureText: true),
            const SizedBox(height: 20),
            PrimaryButton(
              text: "Login",
              onPressed: () {
                loginController.login(
                  usernameController.text,
                  passwordController.text,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
