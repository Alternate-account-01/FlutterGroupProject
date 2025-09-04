import 'package:get/get.dart';
import '../models/todo_model.dart';

class HomeController extends GetxController {
  var todos = <TodoModel>[
    TodoModel(
      title: "Belajar Flutter",
      description: "Membuat aplikasi Todo dengan GetX",
      category: "Sekolah",
      isDone: false,
    ),
    TodoModel(
      title: "Meeting Project",
      description: "Diskusi fitur dengan tim",
      category: "Pekerjaan",
      isDone: false,
    ),
    TodoModel(
      title: "Olahraga",
      description: "Jogging 30 menit di taman",
      category: "Pribadi",
      isDone: true,
    ),
    TodoModel(
      title: "Belanja Bulanan",
      description: "Beli sayur, beras, dan kebutuhan dapur",
      category: "Keluarga",
      isDone: false,
    ),
    TodoModel(
      title: "Baca Buku",
      description: "Selesaikan bab 3 Clean Code",
      category: "Pribadi",
      isDone: false,
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
