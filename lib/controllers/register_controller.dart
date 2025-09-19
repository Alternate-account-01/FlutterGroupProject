
import 'package:get/get.dart';
import '../widgets/snackbar_helper.dart';

class RegisterController {
  void register(String username, String password, String confirmPassword) {
    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      SnackbarHelper.show("Input Incomplete", "All fields are required");
      return;
    }
    if (password != confirmPassword) {
      SnackbarHelper.show("Password Error", "Passwords do not match");
      return;
    }
    SnackbarHelper.show("Success", "Account created successfully!");
    Get.offAllNamed('/login');
  }
}
