import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/task_card.dart';
import '../routes/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addTodo, arguments: {}),
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
            _buildTodayTasksHeader(),
            const SizedBox(height: 16),
            _buildPendingTasksList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: controller.stats
                .map((stat) => _buildStatItem(
                    stat['count'].toString(), stat['label'], stat['color']))
                .toList(),
          )),
    );
  }

  Widget _buildStatItem(String count, String label, Color color) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  Widget _buildTodayTasksHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Today's Tasks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Obx(() => Text(
                "${controller.pendingTodos.length} tasks",
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              )),
        ],
      ),
    );
  }

  Widget _buildPendingTasksList() {
    return Expanded(
      child: Obx(() {
        if (controller.pendingTodos.isEmpty) {
          return const Center(
              child: Text("No pending tasks!",
                  style: TextStyle(fontSize: 18, color: Colors.grey)));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: controller.pendingTodos.length,
          itemBuilder: (context, index) {
            final todoFromPendingList = controller.pendingTodos[index];
            final originalIndex = controller.todos.indexOf(todoFromPendingList);

            return Dismissible(
              key: Key(todoFromPendingList.title + originalIndex.toString()),
              onDismissed: (direction) =>
                  controller.handleDismiss(originalIndex, direction),
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
                  Get.toNamed(AppRoutes.editTodo, arguments: {
                    'todo': fullTodo,
                    'index': originalIndex,
                  });
                },
              ),
            );
          },
        );
      }),
    );
  }
}
