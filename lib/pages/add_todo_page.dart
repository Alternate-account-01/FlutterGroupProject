import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_todo_controller.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  final AddTodoController controller = Get.find<AddTodoController>(); // Gunakan Get.find jika sudah di-lazyPut
  final RxString selectedPriority = "Low Priority".obs;

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
                    _buildHeader(),
                    const SizedBox(height: 20),
                    _buildTextField(controller.titleCtrl, "Task Name *", "Enter task name"),
                    const SizedBox(height: 20),
                    _buildTextField(controller.descCtrl, "Description", "Add a detailed description...", maxLines: 3),
                    const SizedBox(height: 20),
                    _buildUrgencySelector(),
                    const SizedBox(height: 20),
                    _buildTextField(controller.dueDateCtrl, "Due Date", "Select date",
                        readOnly: true, icon: Icons.calendar_today_outlined),
                    const SizedBox(height: 30),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- PERUBAHAN UTAMA ADA DI DALAM FUNGSI INI ---
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Colors.white54),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Cancel", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // --- VALIDASI DAN SNACKBAR DITAMBAHKAN DI SINI (DI DALAM PAGE) ---
              if (controller.titleCtrl.text.trim().isEmpty) {
                // Jika judul kosong, tampilkan snackbar dari bawah
                Get.snackbar(
                  "Input Error",
                  "Task Name is required.",
                  snackPosition: SnackPosition.BOTTOM, // Posisi di bawah
                  backgroundColor: Colors.orange.shade600,
                  colorText: Colors.white,
                  icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
                  margin: const EdgeInsets.all(12),
                  borderRadius: 12,
                );
              } else {
                // Jika valid, lanjutkan proses seperti biasa
                switch (selectedPriority.value) {
                  case "Medium Priority":
                    controller.categoryCtrl.text = "Sekolah";
                    break;
                  case "High Priority":
                    controller.categoryCtrl.text = "Pekerjaan";
                    break;
                  default:
                    controller.categoryCtrl.text = "Pribadi";
                    break;
                }
                controller.saveTodo();
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: const Color(0xFF5A67E8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              "Create Task",
              style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ],
    );
  }

  // Sisa kode tidak ada perubahan
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Add New Task",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back()),
      ],
    );
  }

  Widget _buildUrgencySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Urgency Level *", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 10),
        Obx(() => Row(
              children: [
                _buildPriorityChip("Low Priority"),
                _buildPriorityChip("Medium Priority"),
                _buildPriorityChip("High Priority"),
              ],
            )),
      ],
    );
  }

  Widget _buildTextField(TextEditingController textController, String label,
      String hint,
      {int maxLines = 1, bool readOnly = false, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          controller: textController,
          maxLines: maxLines,
          readOnly: readOnly,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            suffixIcon:
                icon != null ? Icon(icon, color: Colors.white54) : null,
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
          onTap: readOnly && icon == Icons.calendar_today_outlined
              ? () async {
                  final pickedDate = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    textController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  }
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildPriorityChip(String level) {
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
              color: isSelected
                  ? color.withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: isSelected ? color : Colors.white24)),
          child: Row(
            children: [
              Icon(Icons.circle, color: color, size: 14),
              const SizedBox(width: 8),
              Flexible(
                  child: Text(level,
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ),
    );
  }
}