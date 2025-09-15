import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/todo_model.dart';
import 'home_controller.dart';

class AddTodoController extends GetxController {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  final dueDateCtrl = TextEditingController();

  final HomeController homeController = Get.find<HomeController>();

  // guard against duplicate saves
  final RxBool isSaving = false.obs;

  void saveTodo() async {
    if (isSaving.value) return; // prevent re-entry

    final title = titleCtrl.text.trim();
    if (title.isEmpty) {
      _showSnackbar("Error", "Title cannot be empty", Colors.orange);
      return;
    }

    // 🔹 Prevent duplicate titles
    final exists = homeController.todos.any(
      (t) => t.title.trim().toLowerCase() == title.toLowerCase(),
    );

    if (exists) {
      // ✅ only show once, page stays open
      if (!Get.isSnackbarOpen) {
        _showSnackbar("Warning", "Task already exists", Colors.redAccent);
      }
      return;
    }

    isSaving.value = true;
    try {
      final newTodo = TodoModel(
        title: title,
        description: descCtrl.text.trim(),
        category: categoryCtrl.text.trim(),
        dueDate: dueDateCtrl.text.trim(),
      );

      homeController.todos.add(newTodo);
      homeController.todos.refresh();

      // ✅ Immediately exit the page
      Get.back();

      // ✅ Show success while already back on todo list
      _showSnackbar("Success", "Task added successfully!", Colors.green);
    } finally {
      isSaving.value = false;
    }
  }

  void _showSnackbar(String title, String message, Color bgColor) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: bgColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 1), // ⏳ disappear faster
      animationDuration: const Duration(milliseconds: 200), // ⚡ faster slide in/out
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutCubic,
    );
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    categoryCtrl.dispose();
    dueDateCtrl.dispose();
    super.onClose();
  }
}
