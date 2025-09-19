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

  Map<String, dynamic> _getUrgency(String urgency) {
    switch (urgency) {
      case 'High Priority':
        return {'label': 'Urgent', 'color': Colors.red.shade400};
      case 'Medium Priority':
        return {'label': 'Medium', 'color': Colors.orange.shade400};
      case 'Low Priority':
      default:
        return {'label': 'Low', 'color': Colors.green.shade400};
    }
  }

  @override
  Widget build(BuildContext context) {
    final urgency = _getUrgency(todo.urgency);

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
              color: urgency['color'],
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
                    color: Colors.black87,
                  ),
                ),

                
                if (todo.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    todo.description,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],

                const SizedBox(height: 12),

                
                Row(
                  children: [
                    Icon(Icons.circle,
                        color: urgency['color'], size: 10),
                    const SizedBox(width: 4),
                    Text(
                      urgency['label'],
                      style: TextStyle(
                        color: urgency['color'],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      todo.category,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const Spacer(),
                    if (todo.dueDate.isNotEmpty) ...[
                      const Icon(Icons.calendar_today,
                          size: 14, color: Colors.blueGrey),
                      const SizedBox(width: 4),
                      Text(
                        todo.dueDate,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
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
