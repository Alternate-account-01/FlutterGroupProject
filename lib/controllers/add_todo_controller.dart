import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/todo_model.dart';

class AddTodoController extends GetxController {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();

  final HomeController homeController = Get.find<HomeController>();

  void saveTodo() {
    if (titleCtrl.text.isNotEmpty) {
      homeController.todos.add(TodoModel(
        title: titleCtrl.text,
        description: descCtrl.text,
        category: categoryCtrl.text,
      ));
      homeController.todos.refresh();
      Get.back();
    } else {
      Get.snackbar("Error", "Title cannot be empty");
    }
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    categoryCtrl.dispose();
    super.onClose();
  }
}
