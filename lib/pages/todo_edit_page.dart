import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_edit_controller.dart';
import '../widgets/edit_text_field.dart';

class TodoEditPage extends StatelessWidget {
  const TodoEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoEditController>();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: GestureDetector(
        onTap: () => Get.back(),
        child: Center(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {},
              child: TodoEditCard(controller: controller),
            ),
          ),
        ),
      ),
    );
  }
}

class TodoEditCard extends StatelessWidget {
  final TodoEditController controller;
  final RxString selectedCategory = "Personal".obs; // CATEGORY FIELD

  TodoEditCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF2C3E50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Edit Task",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Get.back()),
            ],
          ),
          const SizedBox(height: 20),

          
          CustomTextField(
            controller: controller.titleController,
            label: "Task Name *",
            hint: "Enter task name",
          ),
          const SizedBox(height: 20),

        
          CustomTextField(
            controller: controller.descController,
            label: "Description",
            hint: "Add a detailed description...",
            maxLines: 3,
          ),
          const SizedBox(height: 20),

          
          const Text("Urgency Level *", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 10),
          Obx(() => Row(
                children: [
                  _buildPriorityChip("Low Priority"),
                  _buildPriorityChip("Medium Priority"),
                  _buildPriorityChip("High Priority"),
                ],
              )),
          const SizedBox(height: 20),

          // Category Dropdown
          const Text("Category *", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Obx(() => DropdownButtonFormField<String>(
                value: selectedCategory.value,
                dropdownColor: const Color(0xFF2C3E50),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                ),
                items: ["Work", "Study", "Personal"]
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat, style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) selectedCategory.value = value;
                },
              )),
          const SizedBox(height: 20),


          CustomTextField(
            controller: controller.dueDateController,
            label: "Due Date",
            hint: "Select date",
            readOnly: true,
            icon: Icons.calendar_today_outlined,
            onTap: () => controller.pickDate(context),
          ),
          const SizedBox(height: 30),

   
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.white54),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.categoryController.text = selectedCategory.value;
                    controller.saveTodo();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: const Color(0xFF5A67E8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text("Save Changes",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityChip(String level) {
    final isSelected = controller.selectedPriority.value == level;
    Color color = Colors.grey;
    if (level == "Low Priority") color = Colors.green;
    if (level == "Medium Priority") color = Colors.orange;
    if (level == "High Priority") color = Colors.red;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setPriority(level),
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? color : Colors.white24),
          ),
          child: Row(
            children: [
              Icon(Icons.circle, color: color, size: 14),
              const SizedBox(width: 8),
              Flexible(child: Text(level, style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ),
    );
  }
}
