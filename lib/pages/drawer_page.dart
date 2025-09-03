import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';
import 'dashboard_page.dart';
import 'home_page.dart';
import 'history_page.dart';
import 'profile_page.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({super.key});

  final DrawerControllerX controller = Get.put(DrawerControllerX());
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // ✅ Scaffold key

  final List<Widget> pages = [
   DashboardPage(),
   HomePage(),
   HistoryPage(),
   ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey, // ✅ assign the key
        appBar: AppBar(
          title: const Text("My App"),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // ✅ open drawer safely
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                child: Text(
                  "Navigation",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text("Dashboard"),
                selected:
                    controller.selectedIndex.value == 0, // ✅ highlight active
                onTap: () {
                  controller.changePage(0);
                  Get.back(); // close drawer
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                selected: controller.selectedIndex.value == 1,
                onTap: () {
                  controller.changePage(1);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text("History"),
                selected: controller.selectedIndex.value == 2,
                onTap: () {
                  controller.changePage(2);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                selected: controller.selectedIndex.value == 3,
                onTap: () {
                  controller.changePage(3);
                  Get.back();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  Get.offAllNamed('/login'); // logout
                },
              ),
            ],
          ),
        ),
        body: pages[controller.selectedIndex.value],
      ),
    );
  }
}
