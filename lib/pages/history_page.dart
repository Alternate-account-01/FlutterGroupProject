import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Obx(
        () {
          final completedTodos = controller.completedTodos;

          if (completedTodos.isEmpty) {
            return const Center(
              child: Text("No completed tasks yet"),
            );
          }

          return ListView.builder(
            itemCount: completedTodos.length,
            itemBuilder: (context, index) {
              final todo = completedTodos[index];
              final realIndex = controller.todos.indexOf(todo);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(
                    todo.title,
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough),
                  ),
                  subtitle: Text(todo.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Undo button
                      IconButton(
                        icon: const Icon(Icons.undo, color: Colors.orange),
                        onPressed: () {
                          controller.undoDone(realIndex);
                        },
                      ),
                      // Delete button
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.deleteTodo(realIndex);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
