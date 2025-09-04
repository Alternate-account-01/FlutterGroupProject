import 'package:get/get.dart';
import '../models/todo_model.dart';
import 'home_controller.dart';

class HistoryController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  // Return only completed todos
  List<TodoModel> get completedTodos =>
      homeController.todos.where((todo) => todo.isDone).toList();
}
