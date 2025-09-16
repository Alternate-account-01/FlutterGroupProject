import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/todo_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() {
        final completed = homeController.completedTodos;

        final now = DateTime.now();
        final Map<String, List<TodoModel>> groups = {
          'Today': [],
          'Yesterday': [],
          'Earlier': [],
        };
        for (final t in completed) {
          DateTime? due;
          if (t.dueDate != null && t.dueDate!.isNotEmpty) {
            due = DateTime.tryParse(t.dueDate!);
          }
          String key = 'Earlier';
          if (due != null) {
            final todayDate = DateTime(now.year, now.month, now.day);
            final dueDate = DateTime(due.year, due.month, due.day);
            final diff = todayDate.difference(dueDate).inDays;
            if (diff == 0) key = 'Today';
            else if (diff == 1) key = 'Yesterday';
          }
          groups[key]!.add(t);
        }

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            _buildStatsHeader(completed.length, homeController),
            const SizedBox(height: 12),
            if (groups['Today']!.isNotEmpty)
              _buildGroupSection('Today', groups['Today']!, homeController),
            if (groups['Yesterday']!.isNotEmpty)
              _buildGroupSection(
                  'Yesterday', groups['Yesterday']!, homeController),
            if (groups['Earlier']!.isNotEmpty)
              _buildGroupSection('Earlier', groups['Earlier']!, homeController),
            if (completed.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    'No completed tasks yet.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
            const SizedBox(height: 24),
          ],
        );
      }),
    );
  }

  Widget _buildStatsHeader(int completedCount, HomeController homeController) {
    final allTimeCount = homeController.todos.length;
    const thisMonthCount = 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem(completedCount.toString(), "Completed", Colors.green),
              _statItem(thisMonthCount.toString(), "This Month", Colors.blue),
              _statItem(allTimeCount.toString(), "All Time", Colors.black87),
            ],
          ),
          const SizedBox(height: 16),
          if (completedCount > 0)
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delete_sweep_outlined,
                              color: Colors.red.shade400, size: 50),
                          const SizedBox(height: 16),
                          const Text(
                            "Clear All History?",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "This will permanently delete all ${homeController.completedTodos.length} completed tasks.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text("Cancel",
                                      style:
                                          TextStyle(color: Colors.black87)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    homeController.todos
                                        .removeWhere((t) => t.isDone);
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade400,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Clear",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.delete_outline,
                    color: Colors.red, size: 20),
                label: const Text("Clear History",
                    style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.shade100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 13)),
      ],
    );
  }

  Widget _buildGroupSection(
      String title, List<TodoModel> list, HomeController homeController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ListView.separated(
            itemCount: list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final todo = list[index];
              final realIndex = homeController.todos.indexOf(todo);

              return Dismissible(
                key: Key(todo.title + realIndex.toString()),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    if (realIndex != -1) homeController.undoDone(realIndex);
                    Get.snackbar(
                      'Task Restored',
                      '"${todo.title}" has been moved back to your tasks.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else if (direction == DismissDirection.endToStart) {
                     if (realIndex != -1) homeController.deleteTodo(realIndex);
                     Get.snackbar(
                      'Task Deleted',
                      '"${todo.title}" has been permanently deleted.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.undo_rounded, color: Colors.white),
                ),
                secondaryBackground: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                child: _buildHistoryCard(todo),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(TodoModel todo) {
    final priority = _getPriority(todo.category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade600, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                if (todo.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child:
                        Text(todo.description, style: TextStyle(color: Colors.grey.shade600)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: priority['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(6)
            ),
            child: Text(
              priority['level'],
              style: TextStyle(color: priority['color'], fontWeight: FontWeight.bold, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  Map<String, dynamic> _getPriority(String? category) {
    switch (category) {
      case 'Pekerjaan':
        return {'level': 'Urgent', 'color': Colors.red.shade400};
      case 'Sekolah':
      case 'Keluarga':
        return {'level': 'Medium', 'color': Colors.orange.shade400};
      case 'Pribadi':
      default:
        return {'level': 'Low', 'color': Colors.green.shade400};
    }
  }
}