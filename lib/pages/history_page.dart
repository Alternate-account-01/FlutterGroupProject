import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/todo_model.dart';
import '../widgets/stat_item.dart';
import '../widgets/group_section.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() {
        final completed = homeController.completedTodos;

        // Group completed todos by time
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
              GroupSection(
                title: 'Today',
                list: groups['Today']!,
                homeController: homeController,
                getPriority: _getPriority,
              ),
            if (groups['Yesterday']!.isNotEmpty)
              GroupSection(
                title: 'Yesterday',
                list: groups['Yesterday']!,
                homeController: homeController,
                getPriority: _getPriority,
              ),
            if (groups['Earlier']!.isNotEmpty)
              GroupSection(
                title: 'Earlier',
                list: groups['Earlier']!,
                homeController: homeController,
                getPriority: _getPriority,
              ),

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
              StatItem(value: completedCount.toString(), label: "Completed", color: Colors.green),
              StatItem(value: thisMonthCount.toString(), label: "This Month", color: Colors.blue),
              StatItem(value: allTimeCount.toString(), label: "All Time", color: Colors.black87),
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "This will permanently delete all ${homeController.completedTodos.length} completed tasks.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
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
                                  child: const Text("Cancel", style: TextStyle(color: Colors.black87)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    homeController.todos.removeWhere((t) => t.isDone);
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
                                    "Clear",
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
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                label: const Text("Clear History", style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.shade100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Reusable priority resolver
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
