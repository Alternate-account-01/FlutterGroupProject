import 'package:get/get.dart';
import '../pages/login_page.dart';
import '../pages/drawer_page.dart';
import '../binding/login_binding.dart';
import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DrawerPage(), // 🔹 Wraps everything
    ),
  ];
}
