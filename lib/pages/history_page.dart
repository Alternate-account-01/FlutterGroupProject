import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/history_controller.dart';
import '../widgets/stat_item.dart';
import '../widgets/group_section.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final HistoryController historyController = Get.put(HistoryController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() {
        final completed = historyController.completedTodos;

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            _buildStatsHeader(historyController),
            const SizedBox(height: 12),
            if (completed.isNotEmpty)
              GroupSection(
                title: 'Earlier',
                list: completed,
                homeController: homeController,
                getPriority: historyController.getUrgency,
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

  Widget _buildStatsHeader(HistoryController historyController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatItem(
                    value: historyController.completedCount.toString(),
                    label: "Completed",
                    color: Colors.green,
                  ),
                  StatItem(
                    value: historyController.completedCount.toString(),
                    label: "This Month",
                    color: Colors.blue,
                  ),
                  StatItem(
                    value: historyController.allTimeCount.toString(),
                    label: "All Time",
                    color: Colors.black87,
                  ),
                ],
              )),
          const SizedBox(height: 16),
          Obx(() {
            if (historyController.completedCount == 0) return Container();
            return Align(
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
                          Text(
                            "Clear All History?",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "This will permanently delete all ${historyController.completedCount} completed tasks.",
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
                                  child: const Text("Cancel",
                                      style: TextStyle(color: Colors.black87)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    historyController.clearHistory();
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
                icon: const Icon(Icons.delete_outline,
                    color: Colors.red, size: 20),
                label: const Text("Clear History",
                    style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.shade100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
