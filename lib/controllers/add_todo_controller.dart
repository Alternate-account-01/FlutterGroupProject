import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/todo_model.dart';
import 'home_controller.dart';
import '../widgets/snackbar_helper.dart';

class AddTodoController extends GetxController {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  final dueDateCtrl = TextEditingController();

  final HomeController homeController = Get.find<HomeController>();

 
  final RxBool isSaving = false.obs;

void saveTodo() async {
  if (isSaving.value) return; 

  final title = titleCtrl.text.trim();
  if (title.isEmpty) {
    SnackbarHelper.show("Error", "Title cannot be empty", bgColor: Colors.orange);
    return;
  }

 
  final exists = homeController.todos.any(
    (t) => t.title.trim().toLowerCase() == title.toLowerCase(),
  );

  if (exists) {
    if (!Get.isSnackbarOpen) {
    SnackbarHelper.show("Warning", "Task already exists", bgColor: Colors.redAccent);}
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

    Get.back();

   SnackbarHelper.show("Success", "Task added successfully!", bgColor: Colors.green);


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
    duration: const Duration(seconds: 1),
    animationDuration: const Duration(milliseconds: 200),
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
