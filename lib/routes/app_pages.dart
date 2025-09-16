import 'package:get/get.dart';
import 'package:group_inshallah/binding/drawer_binding.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/home_page.dart';
import '../pages/add_todo_page.dart';
import '../pages/todo_edit_page.dart';
import '../binding/login_binding.dart';
import '../pages/history_page.dart';
import '../pages/drawer_page.dart'; // ✅ import DrawerPage
import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.drawer, // ✅ new
      page: () => DrawerPage(),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: AppRoutes.addTodo,
      page: () => AddTodoPage(),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: AppRoutes.editTodo,
      page: () => TodoEditPage(),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => HistoryPage(),
      binding: DrawerBinding(),
    ),
  ];
}