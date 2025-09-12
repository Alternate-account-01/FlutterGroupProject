import 'package:get/get.dart';
import '../models/todo_model.dart';


class HomeController extends GetxController {
  var todos = <TodoModel>[
    TodoModel(
      title: "Belajar Flutter",
      description: "Membuat aplikasi Todo dengan GetX",
      category: "Sekolah",
      dueDate: "2025-09-15", // dummy date
    ),
    TodoModel(
      title: "Meeting Project",
      description: "Diskusi tentang progres aplikasi",
      category: "Pekerjaan",
      dueDate: "2025-09-20",
    ),
    TodoModel(
      title: "Belanja Bulanan",
      description: "Pergi ke supermarket untuk kebutuhan dapur",
      category: "Pribadi",
      dueDate: "2025-09-18",
    ),
    TodoModel(
      title: "Kumpul Keluarga",
      description: "Makan malam bersama keluarga besar",
      category: "Keluarga",
      dueDate: "2025-09-22",
    ),
    TodoModel(
      title: "Mengerjakan Tugas Matematika",
      description: "Kerjakan soal latihan bab aritmatika",
      category: "Sekolah",
      dueDate: "2025-09-25",
    ),
  ].obs;

  // Add new task
  void addTodo(TodoModel todo) {
    todos.add(todo);
  }

  // Mark task as done
  void markDone(int index) {
    todos[index].isDone = true;
    todos.refresh();
  }

  // Undo completed task
  void undoDone(int index) {
    todos[index].isDone = false;
    todos.refresh();
  }

  // Delete task
  void deleteTodo(int index) {
    todos.removeAt(index);
  }

  // Pending tasks
  List<TodoModel> get pendingTodos =>
      todos.where((todo) => !todo.isDone).toList();

  // Completed tasks
  List<TodoModel> get completedTodos =>
      todos.where((todo) => todo.isDone).toList();
}
