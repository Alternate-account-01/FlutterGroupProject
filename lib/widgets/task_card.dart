import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TaskCard extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onMarkDone;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskCard({
    super.key,
    required this.todo,
    required this.onMarkDone,
    required this.onDelete,
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
          // Left color bar
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: priority['color'],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),

          // Task content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),

                if (todo.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      todo.description,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),

                // Priority + Due Date
                Row(
                  children: [
                    Icon(Icons.circle, color: priority['color'], size: 10),
                    const SizedBox(width: 4),
                    Text(
                      priority['level'],
                      style: TextStyle(
                        color: priority['color'],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    if (todo.dueDate != null && todo.dueDate!.isNotEmpty)
                      Text(
                        "Due: ${todo.dueDate}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Options menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: Colors.grey),
            onSelected: (value) {
              if (value == 'done') onMarkDone();
              if (value == 'edit') onEdit();
              if (value == 'delete') onDelete();
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'done', child: Text('Mark as Done')),
              const PopupMenuItem(value: 'edit', child: Text('Edit Task')),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }
}
