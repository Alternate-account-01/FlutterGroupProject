import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_todo_controller.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  final AddTodoController controller = Get.find<AddTodoController>();
  final RxString selectedPriority = "Low Priority".obs;
  final RxString selectedCategory = "Personal".obs; // NEW CATEGORY DROPDOWN

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: GestureDetector(
        onTap: () => Get.back(),
        child: Center(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {},
              child: Container(
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
                        const Text(
                          "Add New Task",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Task Name
                    _buildTextField(controller.titleCtrl, "Task Name *", "Enter task name"),
                    const SizedBox(height: 20),

                    // Description
                    _buildTextField(controller.descCtrl, "Description", "Add a detailed description...", maxLines: 3),
                    const SizedBox(height: 20),

                    // Urgency
                    const Text("Urgency Level *", style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 10),
                    Obx(() => Row(
                          children: ["Low Priority", "Medium Priority", "High Priority"].map((level) {
                            bool isSelected = selectedPriority.value == level;
                            Color color = Colors.grey;
                            if (level == "Low Priority") color = Colors.green;
                            if (level == "Medium Priority") color = Colors.orange;
                            if (level == "High Priority") color = Colors.red;

                            return Expanded(
                              child: GestureDetector(
                                onTap: () => selectedPriority.value = level,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: isSelected ? color : Colors.white24),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.circle, color: color, size: 14),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          level,
                                          style: const TextStyle(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
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

                    // Due Date
                    _buildTextField(controller.dueDateCtrl, "Due Date", "Select date",
                        readOnly: true,
                        icon: Icons.calendar_today_outlined,
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: Get.context!,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            controller.dueDateCtrl.text =
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                          }
                        }),
                    const SizedBox(height: 30),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: Colors.white54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.categoryCtrl.text = selectedCategory.value;
                              controller.saveTodo();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: const Color(0xFF5A67E8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Create Task",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String label, String hint,
      {int maxLines = 1, bool readOnly = false, IconData? icon, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            suffixIcon: icon != null ? Icon(icon, color: Colors.white54) : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white24)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white24)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF5A67E8))),
          ),
        ),
      ],
    );
  }
}
