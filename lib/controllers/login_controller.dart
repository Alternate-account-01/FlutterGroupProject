import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoggedIn = false.obs;

  void login(String username, String password) {
    if (username == 'admin' && password == 'admin') {
      isLoggedIn.value = true;
      Get.snackbar("Success", "Welcome back, admin!");
      Get.offAllNamed('/drawer');
    } else {
      Get.snackbar("Error", "Invalid username or password");
    }
  }
}