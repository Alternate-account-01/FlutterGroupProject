import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  void register(String username, String password, String confirmPassword) {
    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    // ✅ Dummy success
    Get.snackbar("Success", "Account created successfully");
    Get.offAllNamed('/login');
  }
}
