import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class ItemTodo extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onToggleDone;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ItemTodo({
    super.key,
    required this.todo,
    required this.onToggleDone,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: todo.isDone ? Colors.grey.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggleDone,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 12, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(
                    todo.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: todo.isDone ? Colors.green : Colors.blue.shade700,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: todo.isDone ? Colors.grey.shade600 : Colors.black87,
                          decoration: todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      const SizedBox(height: 6),

                      if (todo.description.isNotEmpty)
                        Text(
                          todo.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: todo.isDone ? Colors.grey.shade500 : Colors.black54,
                            height: 1.4,
                          ),
                        ),
                      const SizedBox(height: 10),

                      if (todo.category.isNotEmpty)
                        Chip(
                          label: Text(todo.category),
                          labelStyle: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.w500,
                          ),
                          backgroundColor: Colors.blue.shade50,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          labelPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit_outlined, color: Colors.blue.shade700),
                      onPressed: onEdit,
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(4),
                    ),
                    const SizedBox(height: 8),
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
                      onPressed: onDelete,
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}