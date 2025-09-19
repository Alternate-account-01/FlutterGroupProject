import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/add_todo_controller.dart';
import '../controllers/todo_edit_controller.dart';
import '../controllers/history_controller.dart';

class DrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawerControllerX>(() => DrawerControllerX());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AddTodoController>(() => AddTodoController());
    Get.lazyPut<TodoEditController>(() => TodoEditController());
    Get.lazyPut<HistoryController>(() => HistoryController()); 
  }
}
