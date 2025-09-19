import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/todo_model.dart';
import '../widgets/snackbar_helper.dart';

class HomeController extends GetxController {
  var todos = <TodoModel>[].obs;

  void addTodo(TodoModel todo) {
    todos.add(todo);
  }

  void markDone(int index) {
    todos[index].isDone = true;
    todos.refresh();
  }

  void undoDone(int index) {
    todos[index].isDone = false;
    todos.refresh();
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
  }

  List<TodoModel> get pendingTodos =>
      todos.where((todo) => !todo.isDone).toList();

  List<TodoModel> get completedTodos =>
      todos.where((todo) => todo.isDone).toList();

  int get totalTasks => todos.length;

  int get urgentTodos =>
      todos.where((t) => t.category == 'Pekerjaan' && !t.isDone).length;

  void handleDismiss(int index, DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
 
      final taskTitle = todos[index].title;
      markDone(index);

      SnackbarHelper.show(
        'Task Completed!',
        '"$taskTitle" has been moved to history.',
        bgColor: Colors.green,
      );
    } else if (direction == DismissDirection.startToEnd) {
      
      final removedTodo = todos[index];
      todos.removeAt(index);

      SnackbarHelper.show(
        'Task Deleted',
        '"${removedTodo.title}" deleted',
        bgColor: Colors.red.shade400,
        actionLabel: "UNDO",
        onAction: () => todos.insert(index, removedTodo),
      );
    }
  }

  void showDeleteDialog(int index) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_forever_rounded,
                color: Colors.red.shade400, size: 50),
            const SizedBox(height: 16),
            const Text("Delete Permanently?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("This action cannot be undone.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 14)),
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
                      if (index != -1) deleteTodo(index);
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
  }
}
