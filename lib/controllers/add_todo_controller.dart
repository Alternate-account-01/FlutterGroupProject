import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/todo_model.dart';
import 'home_controller.dart';
import '../widgets/snackbar_helper.dart';

class AddTodoController extends GetxController {

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final dueDateCtrl = TextEditingController();


  final RxString selectedPriority = "Low Priority".obs;
  final RxString selectedCategory = "Personal".obs;


  final RxBool isSaving = false.obs;

  final HomeController homeController = Get.find<HomeController>();


  void saveTodo() async {
    if (isSaving.value) return;

    final title = titleCtrl.text.trim();
    if (title.isEmpty) {
      SnackbarHelper.show("Error", "Title cannot be empty",
          bgColor: Colors.orange);
      return;
    }

    final exists = homeController.todos.any(
      (t) => t.title.trim().toLowerCase() == title.toLowerCase(),
    );

    if (exists) {
      if (!Get.isSnackbarOpen) {
        SnackbarHelper.show("Warning", "Task already exists",
            bgColor: Colors.redAccent);
      }
      return;
    }

    isSaving.value = true;
    try {
      final newTodo = TodoModel(
        title: title,
        description: descCtrl.text.trim(),
        urgency: selectedPriority.value,   // ⚡ use selectedPriority
        category: selectedCategory.value,  // ⚡ use selectedCategory
        dueDate: dueDateCtrl.text.trim(),
      );

      homeController.todos.add(newTodo);
      homeController.todos.refresh();

      Get.back();

      SnackbarHelper.show("Success", "Task added successfully!",
          bgColor: Colors.green);
    } finally {
      isSaving.value = false;
    }
  }

  void setPriority(String priority) {
    selectedPriority.value = priority;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    dueDateCtrl.dispose();
    super.onClose();
  }
}
