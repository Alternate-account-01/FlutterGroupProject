import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/todo_model.dart';
import 'add_todo_page.dart';
import 'todo_edit_page.dart';
import '../routes/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddTodoPage
          Get.toNamed(AppRoutes.addTodo);
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.todos.length,
            itemBuilder: (context, index) {
              final todo = controller.todos[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      controller.toggleDone(index);
                      Get.snackbar(
                        "Todo Updated",
                        todo.isDone ? "Marked as done" : "Marked as not done",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.blueAccent,
                        colorText: Colors.white,
                      );
                    },
                    leading: Icon(
                      todo.isDone
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: todo.isDone ? Colors.green : Colors.grey,
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text("${todo.category} • ${todo.description}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit Button
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.editTodo,
                              arguments: {
                                'todo': controller.todos[index],
                                'index': index,
                              },
                            );
                          },
                        ),
                        // Delete Button
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.deleteTodo(index),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
