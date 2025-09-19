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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.history_rounded,
                size: 26,
                color: controller.selectedIndex.value == 1
                    ? const Color(0xFF6777EF)
                    : Colors.grey[700],
              ),
              tooltip: "History",
              onPressed: () => controller.changePage(1),
            ),
            IconButton(
              icon: Icon(
                Icons.list_alt_rounded,
                size: 26,
                color: controller.selectedIndex.value == 0
                    ? const Color(0xFF6777EF)
                    : Colors.grey[700],
              ),
              tooltip: "Todo List",
              onPressed: () => controller.changePage(0),
            ),
            const SizedBox(width: 8),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const Padding(
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
                                fontSize: 20,
                              ),
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
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 20, bottom: 8),
                      child: Text(
                        "MENU",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),

      
                    Obx(() {
                      bool isSelected = controller.selectedIndex.value == 0;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF6777EF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.list_alt_rounded,
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                          title: Text(
                            "Todo List",
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[800],
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          trailing: CircleAvatar(
                            radius: 12,
                            backgroundColor: isSelected ? Colors.white : Colors.grey[200],
                            child: Text(
                              "6",
                              style: TextStyle(
                                color: isSelected ? const Color(0xFF6777EF) : Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onTap: () {
                            controller.changePage(0);
                            Get.back();
                          },
                        ),
                      );
                    }),

                 
                    Obx(() {
                      bool isSelected = controller.selectedIndex.value == 1;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF6777EF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.history_rounded,
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                          title: Text(
                            "History",
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[800],
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          onTap: () {
                            controller.changePage(1);
                            Get.back();
                          },
                        ),
                      );
                    }),

        
                    Obx(() {
                      bool isSelected = controller.selectedIndex.value == 2;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF6777EF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.person_outline_rounded,
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                          title: Text(
                            "Profile",
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[800],
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          onTap: () {
                            controller.changePage(2);
                            Get.back();
                          },
                        ),
                      );
                    }),
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
                onTap: () => Get.offAllNamed('/login'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        body: pages[controller.selectedIndex.value],
      ),
    );
  }
}
