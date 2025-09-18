import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/todo_model.dart';
import '../widgets/snackbar_helper.dart';
import 'history_card.dart';

class GroupSection extends StatelessWidget {
  final String title;
  final List<TodoModel> list;
  final HomeController homeController;
  final Map<String, dynamic> Function(String?) getPriority;

  const GroupSection({
    super.key,
    required this.title,
    required this.list,
    required this.homeController,
    required this.getPriority,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                    // Restore task
                    if (realIndex != -1) homeController.undoDone(realIndex);

                    SnackbarHelper.show(
                      "Task Restored",
                      "\"${todo.title}\" has been moved back to your tasks.",
                      bgColor: Colors.orange,
                      actionLabel: "UNDO",
                      onAction: () {
                        if (realIndex != -1) {
                          homeController.markDone(realIndex);
                        }
                      },
                    );
                  } else if (direction == DismissDirection.endToStart) {
                    // Delete permanently
                    if (realIndex != -1) {
                      final removedTodo = todo;
                      homeController.deleteTodo(realIndex);

                      SnackbarHelper.show(
                        "Task Deleted",
                        "\"${removedTodo.title}\" has been permanently deleted.",
                        bgColor: Colors.red.shade400,
                        actionLabel: "UNDO",
                        onAction: () {
                          homeController.todos.insert(realIndex, removedTodo);
                        },
                      );
                    }
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
                child: HistoryCard(
                  todo: todo,
                  getPriority: getPriority,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
