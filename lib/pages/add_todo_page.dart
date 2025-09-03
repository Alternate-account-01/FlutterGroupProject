import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_todo_controller.dart';
import '../models/todo_model.dart';
import '../widgets/InputField.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/item_Todo.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {

    final AddTodoController controller = Get.find<AddTodoController>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      "Create a New Task",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Fill in the details below to add a new todo.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 32),
                    InputField(
                      controller: controller.titleCtrl,
                      hint: "Title",
                      icon: Icons.title_rounded,
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      controller: controller.descCtrl,
                      hint: "Description",
                      icon: Icons.description_outlined,
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      controller: controller.categoryCtrl,
                      hint: "Category",
                      icon: Icons.category_outlined,
                    ),
                    const SizedBox(height: 32),
                    PrimaryButton(
                      text: "Add Todo",
                      onPressed: controller.saveTodo,
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Live Preview",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      final todo = TodoModel(
                        title: controller.titleCtrl.text.isEmpty
                            ? "Your Title"
                            : controller.titleCtrl.text,
                        description: controller.descCtrl.text.isEmpty
                            ? "Your description will appear here."
                            : controller.descCtrl.text,
                        category: controller.categoryCtrl.text.isEmpty
                            ? "Category"
                            : controller.categoryCtrl.text,
                        isDone: false,
                      );
                      return ItemTodo(
                        todo: todo,
                        onToggleDone: () {},
                        onEdit: () {},
                        onDelete: () {},
                      );
                    }),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}