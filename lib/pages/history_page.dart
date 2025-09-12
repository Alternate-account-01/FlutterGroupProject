import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/todo_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final now = DateTime.now();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      
      body: Obx(() {
        final List<TodoModel> completed = homeController.completedTodos;

        // Stats
        final int completedCount = completed.length;
        final int thisMonthCount = completed.where((t) {
          if (t.dueDate == null || t.dueDate!.isEmpty) return false;
          final dt = DateTime.tryParse(t.dueDate!);
          return dt != null && dt.month == now.month && dt.year == now.year;
        }).length;
        final int allTimeCount = homeController.todos.length;

        // Group by due date relative to today
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
            if (diff == 0) {
              key = 'Today';
            } else if (diff == 1) {
              key = 'Yesterday';
            } else {
              key = 'Earlier';
            }
          }
          groups[key]!.add(t);
        }

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            // Stats header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statItem(completedCount.toString(), "Completed", Colors.green),
                      _statItem(thisMonthCount.toString(), "This Month", Colors.blue),
                      _statItem(allTimeCount.toString(), "All Time", Colors.black87),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // clear completed tasks
                        Get.defaultDialog(
                          title: 'Clear all history?',
                          middleText: 'This will remove all completed tasks permanently.',
                          textCancel: 'Cancel',
                          textConfirm: 'Clear',
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            homeController.todos.removeWhere((t) => t.isDone);
                            Get.back();
                          },
                        );
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      label: const Text("Clear All", style: TextStyle(color: Colors.red)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red.shade100),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Group sections in order
            if (groups['Today']!.isNotEmpty) _buildGroupSection('Today', groups['Today']!, homeController),
            if (groups['Yesterday']!.isNotEmpty) _buildGroupSection('Yesterday', groups['Yesterday']!, homeController),
            if (groups['Earlier']!.isNotEmpty) _buildGroupSection('Earlier', groups['Earlier']!, homeController),
            const SizedBox(height: 24),
          ],
        );
      }),
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

  Widget _buildGroupSection(String title, List<TodoModel> list, HomeController homeController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header row: Title + count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("${list.length} completed", style: TextStyle(color: Colors.green.shade600)),
            ],
          ),
          const SizedBox(height: 8),
          // items
          ...list.map((todo) {
            final realIndex = homeController.todos.indexOf(todo);
            final priority = _getPriority(todo.category);
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 3)),
                ],
              ),
              child: Row(
                children: [
                  // left checked icon
                  Icon(Icons.check_circle, color: Colors.green.shade600, size: 26),
                  const SizedBox(width: 12),

                  // content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(todo.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
                        if (todo.description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0, bottom: 6),
                            child: Text(todo.description, style: TextStyle(color: Colors.grey.shade600)),
                          ),
                        Row(
                          children: [
                            Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: priority['color'])),
                            const SizedBox(width: 6),
                            Text("Was ${priority['level']}", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                            const Spacer(),
                            if (todo.dueDate != null && todo.dueDate!.isNotEmpty)
                              Text("Due: ${todo.dueDate}", style: const TextStyle(color: Colors.green, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // actions column: undo + delete
                  Column(
                    children: [
                      // Undo with confirmation
                      IconButton(
                        onPressed: () {
                          if (realIndex != -1) {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                title: const Text('Undo Task?'),
                                content: const Text('Are you sure you want to mark this task as not completed?'),
                                actions: [
                                  TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                                  TextButton(
                                    onPressed: () {
                                      homeController.undoDone(realIndex);
                                      Get.back();
                                    },
                                    child: const Text('Yes, Undo'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        icon: Icon(Icons.undo_rounded, color: Colors.orange.shade400),
                        tooltip: 'Undo',
                      ),

                      // Delete
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade100),
                          color: Colors.red.shade50,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                title: const Text('Delete Permanently?'),
                                content: const Text('This action cannot be undone.'),
                                actions: [
                                  TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
                                  TextButton(
                                    onPressed: () {
                                      if (realIndex != -1) homeController.deleteTodo(realIndex);
                                      Get.back();
                                    },
                                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.close, color: Colors.red),
                          tooltip: 'Delete',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Priority helper
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
