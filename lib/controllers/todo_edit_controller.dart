import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/todo_model.dart';

class TodoEditController extends GetxController {
  final HomeController homeController = Get.find();

  late int todoIndex;
  late TodoModel todo;

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final urgencyController = TextEditingController();   // dropdown
  final categoryController = TextEditingController();  // priority
  final dueDateController = TextEditingController();

  final RxString selectedPriority = "Low".obs;     // category
  final RxString selectedUrgency = "Work".obs;     // urgency

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    todo = args['todo'];
    todoIndex = args['index'];

    titleController.text = todo.title;
    descController.text = todo.description;
    urgencyController.text = todo.urgency;
    categoryController.text = todo.category;
    dueDateController.text = todo.dueDate;

    selectedUrgency.value = todo.urgency;
    selectedPriority.value = todo.category;
  }

  void pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(dueDateController.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dueDateController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  void setPriority(String level) {
    selectedPriority.value = level;
    categoryController.text = level; // "Low", "Medium", "High"
  }

  void setUrgency(String type) {
    selectedUrgency.value = type;
    urgencyController.text = type; // "Work", "Study", "Personal"
  }

  void saveTodo() {
    final updatedTodo = TodoModel(
      title: titleController.text.trim(),
      description: descController.text.trim(),
      urgency: urgencyController.text.trim(),
      category: categoryController.text.trim(),
      dueDate: dueDateController.text.trim(),
      isDone: todo.isDone,
    );

    homeController.todos[todoIndex] = updatedTodo;
    homeController.todos.refresh();
    Get.back();
  }
}
