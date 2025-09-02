import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoggedIn = false.obs;

  void login(String username, String password) {
    // Dummy login check
    if (username == 'admin' && password == 'admin') {
      isLoggedIn.value = true;
      Get.offAllNamed('/dashboard');
    } else {
      Get.snackbar('Error', 'Invalid username or password');
    }
  }
}
