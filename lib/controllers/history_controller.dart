import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/todo_model.dart';
import 'home_controller.dart';

class HistoryController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

 
  RxList<TodoModel> get completedTodos =>
      homeController.todos.where((todo) => todo.isDone).toList().obs;

 
  int get completedCount => completedTodos.length;
  int get allTimeCount => homeController.todos.length;

 
  void clearHistory() {
    homeController.todos.removeWhere((t) => t.isDone);
  }

  // Map urgency to UI
  Map<String, dynamic> getUrgency(String? urgency) {
    switch (urgency) {
      case 'High Priority':
        return {'level': 'High Priority', 'color': Colors.red.shade400};
      case 'Medium Priority':
        return {'level': 'Medium Priority', 'color': Colors.orange.shade400};
      case 'Low Priority':
      default:
        return {'level': 'Low Priority', 'color': Colors.green.shade400};
    }
  }
}
