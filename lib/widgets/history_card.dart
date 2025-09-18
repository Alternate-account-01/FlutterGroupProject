import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class HistoryCard extends StatelessWidget {
  final TodoModel todo;
  final Map<String, dynamic> Function(String urgency) getPriority;

  const HistoryCard({
    super.key,
    required this.todo,
    required this.getPriority,
  });

  @override
  Widget build(BuildContext context) {
    final priority = getPriority(todo.urgency); // urgency => Urgent/Medium/Low

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green.shade600, size: 26),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                // Description (optional)
                if (todo.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      todo.description,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),

                // Category (Work/Study/Personal)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.folder_copy_outlined,
                          size: 14, color: Colors.blueGrey),
                      const SizedBox(width: 4),
                      Text(
                        todo.category, // Work / Study / Personal
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),

                // Due date (optional)
                if (todo.dueDate.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 14, color: Colors.blueGrey),
                        const SizedBox(width: 4),
                        Text(
                          todo.dueDate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Priority badge (Urgent/Medium/Low)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: priority['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              priority['level'],
              style: TextStyle(
                color: priority['color'],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
