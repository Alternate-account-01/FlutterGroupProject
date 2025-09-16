import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_todo_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/todo_edit_controller.dart';
import '../controllers/drawer_controller.dart';
import '../widgets/task_card.dart';
import 'add_todo_page.dart';
import 'todo_edit_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.lazyPut(() => AddTodoController());
          Get.to(
            () => AddTodoPage(),
            fullscreenDialog: true,
            opaque: false,
            transition: Transition.fadeIn,
          );
        },
        backgroundColor: const Color(0xFF6756D6),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _buildStatsHeader(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Tasks",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => Text(
                      "${controller.pendingTodos.length} tasks",
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.pendingTodos.isEmpty) {
                  return const Center(
                    child: Text(
                      "No pending tasks!",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.pendingTodos.length,
                  itemBuilder: (context, index) {
                    final todoFromPendingList = controller.pendingTodos[index];
                    final originalIndex =
                        controller.todos.indexOf(todoFromPendingList);

                    return Dismissible(
                      key: Key(todoFromPendingList.title +
                          originalIndex.toString()),
                      
                      // --- LOGIKA SWIPE TERBARU DITERAPKAN DI SINI ---
                      onDismissed: (direction) {
                        // JIKA GESER KIRI (MARK AS COMPLETE) -> AKSI LANGSUNG
                        if (direction == DismissDirection.endToStart) {
                          final taskTitle = controller.todos[originalIndex].title;
                          controller.markDone(originalIndex);
                          Get.snackbar(
                            'Task Completed!',
                            '"$taskTitle" has been moved to history.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        } 
                        // JIKA GESER KANAN (DELETE) -> DENGAN OPSI UNDO
                        else if (direction == DismissDirection.startToEnd) {
                          final removedTodo = controller.todos[originalIndex];
                          controller.todos.removeAt(originalIndex);

                          Get.snackbar(
                            'Task Deleted',
                            '"${removedTodo.title}"',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 4),
                            backgroundColor: Colors.red.shade400,
                            colorText: Colors.white,
                            mainButton: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                                ),
                              ),
                              onPressed: () {
                                controller.todos.insert(originalIndex, removedTodo);
                                if (Get.isSnackbarOpen) {
                                  Get.back();
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "UNDO",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Icon(Icons.delete_outline, color: Colors.white),
                      ),
                      
                      secondaryBackground: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.check, color: Colors.white),
                      ),
                      
                      child: TaskCard(
                        todo: todoFromPendingList,
                        onEdit: () {
                          final fullTodo = controller.todos[originalIndex];
                          Get.to(
                            () => const TodoEditPage(),
                            arguments: {
                              'todo': fullTodo,
                              'index': originalIndex,
                            },
                            binding: BindingsBuilder(() {
                              Get.lazyPut(() => TodoEditController());
                            }),
                            // Menambahkan efek overlay
                            opaque: false,
                            fullscreenDialog: true,
                            transition: Transition.fadeIn,
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Sisa kode tidak ada perubahan
  Widget _buildStatsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem(
              controller.todos.length.toString(),
              "Total Tasks",
              Colors.blue,
            ),
            _buildStatItem(
              controller.completedTodos.length.toString(),
              "Completed",
              Colors.green,
            ),
            _buildStatItem(
              controller.pendingTodos.length.toString(),
              "Pending",
              Colors.orange,
            ),
            _buildStatItem(
              controller.todos
                  .where((t) => t.category == 'Pekerjaan' && !t.isDone)
                  .length
                  .toString(),
              "Urgent",
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, int index) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.delete_forever_rounded,
              color: Colors.red.shade400,
              size: 50,
            ),
            const SizedBox(height: 16),
            const Text(
              "Delete Permanently?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "This action cannot be undone.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (index != -1) {
                        controller.deleteTodo(index);
                      }
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}