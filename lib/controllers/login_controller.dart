import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/snackbar_helper.dart';

class LoginController extends GetxController {
  var isLoggedIn = false.obs;


  void showEmptyFieldsError() {
    SnackbarHelper.show(
      'Input Incomplete',
      'Username and password cannot be empty.',
      bgColor: Colors.orange.shade600,
    );
  }
  void login(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      showEmptyFieldsError();
      return;
    }

    if (username == 'admin' && password == 'admin') {
      isLoggedIn.value = true;
      Get.offAllNamed('/drawer');
      SnackbarHelper.show(
        'Login Successful',
        'Welcome back, admin!',
        bgColor: Colors.green,
      );
    } else {
      SnackbarHelper.show(
        'Login Failed',
        'Invalid username or password.',
        bgColor: Colors.red.shade400,
      );
    }
  }
}
