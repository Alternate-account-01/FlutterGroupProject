import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_edit_controller.dart';
import '../widgets/InputField.dart';
import '../widgets/PrimaryButton.dart';

class TodoEditPage extends StatelessWidget {
  const TodoEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoEditController controller = Get.find<TodoEditController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit Todo",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Task Details",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            InputField(
              controller: controller.titleController,
              hint: "Title",
              icon: Icons.title_rounded,
            ),
            const SizedBox(height: 16),
            InputField(
              controller: controller.descController,
              hint: "Description",
              icon: Icons.description_outlined,
            ),
            const SizedBox(height: 16),
            InputField(
              controller: controller.categoryController,
              hint: "Category",
              icon: Icons.category_outlined,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: "Save Changes",
              onPressed: controller.saveTodo,
            ),
          ],
        ),
      ),
    );
  }
}