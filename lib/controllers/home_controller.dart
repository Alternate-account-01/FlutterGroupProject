import 'package:get/get.dart';
import '../models/todo_model.dart';

class HomeController extends GetxController {
  var todos = <TodoModel>[
    TodoModel(
      title: "Belajar Flutter",
      description: "Membuat aplikasi Todo dengan GetX",
      category: "Sekolah",
    ),
    TodoModel(
      title: "Meeting Project",
      description: "Diskusi fitur dengan tim",
      category: "Pekerjaan",
    ),
    TodoModel(
      title: "Olahraga",
      description: "Jogging 30 menit",
      category: "Pribadi",
    ),
  ].obs;

  void addTodo(TodoModel todo) {
    todos.add(todo);
  }

  void toggleDone(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
  }
}
