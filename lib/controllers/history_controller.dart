import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/todo_model.dart';
import 'home_controller.dart';

class HistoryController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  List<TodoModel> get completedTodos =>
      homeController.todos.where((todo) => todo.isDone).toList();

 
  Map<String, dynamic> getUrgency(String? category) {
    switch (category) {
      case 'Pekerjaan':
        return {'level': 'High Priority', 'color': Colors.red.shade400};
      case 'Sekolah':
      case 'Keluarga':
        return {'level': 'Medium Priority', 'color': Colors.orange.shade400};
      case 'Pribadi':
      default:
        return {'level': 'Low Priority', 'color': Colors.green.shade400};
    }
  }
}
