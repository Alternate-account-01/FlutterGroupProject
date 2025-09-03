import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class DashboardController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  int get totalTodos => homeController.todos.length;
  int get completedTodos =>
      homeController.todos.where((t) => t.isDone).length;
  int get pendingTodos =>
      homeController.todos.where((t) => !t.isDone).length;

  // You can add more dashboard logic here later
}
