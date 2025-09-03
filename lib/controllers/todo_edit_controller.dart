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
  final categoryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    todo = args['todo'];
    todoIndex = args['index'];

    titleController.text = todo.title;
    descController.text = todo.description;
    categoryController.text = todo.category;
  }

  void saveTodo() {
    final updatedTodo = TodoModel(
      title: titleController.text.trim(),
      description: descController.text.trim(),
      category: categoryController.text.trim(),
      isDone: todo.isDone,
    );

    homeController.todos[todoIndex] = updatedTodo;
    homeController.todos.refresh();
    Get.back();
  }
}
