import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';
import '../controllers/home_controller.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final HistoryController controller = Get.put(HistoryController());
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Task History",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Obx(() {
        // ambil langsung dari controller supaya reaktif
        final completedTodos = controller.completedTodos;

        if (completedTodos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history_toggle_off_rounded,
                    size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                const Text(
                  "No completed tasks yet",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Completed tasks will appear here.",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: completedTodos.length,
          itemBuilder: (context, index) {
            final todo = completedTodos[index];
            final realIndex = homeController.todos.indexOf(todo);

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: Colors.green, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        if (todo.description.isNotEmpty)
                          Text(
                            todo.description,
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.undo_rounded,
                        color: Colors.orange.shade400),
                    onPressed: () {
                      if (realIndex != -1) {
                        homeController.undoDone(realIndex);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever_outlined,
                        color: Colors.red.shade400),
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(24, 20, 24, 24),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.delete_forever_rounded,
                                  color: Colors.red.shade400, size: 50),
                              const SizedBox(height: 16),
                              const Text("Delete Permanently?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              const Text(
                                "This action cannot be undone.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => Get.back(),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        side: BorderSide(
                                            color: Colors.grey.shade300),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text("Cancel",
                                          style: TextStyle(
                                              color: Colors.black87)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (realIndex != -1) {
                                          homeController.deleteTodo(realIndex);
                                        }
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red.shade400,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text("Delete",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
