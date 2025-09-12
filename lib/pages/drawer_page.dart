import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';
import 'home_page.dart';
import 'history_page.dart';
import 'profile_page.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({super.key});

  final DrawerControllerX controller = Get.put(DrawerControllerX());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> pages = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  final List<String> pageTitles = [
    "My Tasks",
    "History",
    "My Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.grey[800],
          centerTitle: true,
          title: Text(
            pageTitles[controller.selectedIndex.value],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.schedule_outlined, size: 26),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined, size: 26),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
        drawer: _buildDrawer(),
        body: pages[controller.selectedIndex.value],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerHeader(),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 20, bottom: 8),
                  child: Text(
                    "MENU",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                _buildMenuItem(
                  icon: Icons.list_alt_rounded,
                  title: "Todo List",
                  index: 0,
                  badgeCount: 6,
                ),
                _buildMenuItem(
                  icon: Icons.history_rounded,
                  title: "History",
                  index: 1,
                ),
                _buildMenuItem(
                  icon: Icons.person_outline_rounded,
                  title: "Profile",
                  index: 2,
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Get.offAllNamed('/login');
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 60, 16, 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFF6777EF),
            child: Text(
              "JD",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "John Doe",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "john.doe@email.com",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required int index,
    int badgeCount = 0,
  }) {
    bool isSelected = controller.selectedIndex.value == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF6777EF) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.white : Colors.grey[600]),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: badgeCount > 0
            ? CircleAvatar(
                radius: 12,
                backgroundColor: isSelected ? Colors.white : Colors.grey[200],
                child: Text(
                  badgeCount.toString(),
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF6777EF) : Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: () {
          controller.changePage(index);
          Get.back();
        },
      ),
    );
  }
}