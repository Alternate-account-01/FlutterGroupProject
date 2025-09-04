import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_todo_controller.dart';
import '../widgets/InputField.dart';
import '../widgets/PrimaryButton.dart';

class AddTodoPage extends GetView<AddTodoController> {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add New Todo",
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
              "Task Details",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

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
          ],
        ),
      ),
    );
  }
}
