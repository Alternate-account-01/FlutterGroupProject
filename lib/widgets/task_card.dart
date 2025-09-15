import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TaskCard extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onEdit;

  const TaskCard({
    super.key,
    required this.todo,
    required this.onEdit,
  });

  Map<String, dynamic> _getPriority(String category) {
    switch (category) {
      case 'Pekerjaan':
        return {'level': 'Urgent', 'color': Colors.red.shade400};
      case 'Sekolah':
      case 'Keluarga':
        return {'level': 'Medium', 'color': Colors.orange.shade400};
      case 'Pribadi':
      default:
        return {'level': 'Low', 'color': Colors.green.shade400};
    }
  }

  @override
  Widget build(BuildContext context) {
    final priority = _getPriority(todo.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: priority['color'],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(todo.description,
                    style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.circle, color: priority['color'], size: 10),
                    const SizedBox(width: 4),
                    Text(priority['level'],
                        style: TextStyle(
                            color: priority['color'],
                            fontWeight: FontWeight.w500)),
                    const Spacer(),
                    const Text("2h ago",
                        style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),

          IconButton(
            icon: Icon(Icons.edit_outlined, color: Colors.grey.shade600),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}