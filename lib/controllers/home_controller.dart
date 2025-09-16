import 'package:get/get.dart';
import '../models/todo_model.dart';


class HomeController extends GetxController {
  var todos = <TodoModel>[
  ].obs;

 
  void addTodo(TodoModel todo) {
    todos.add(todo);
  }


  void markDone(int index) {
    todos[index].isDone = true;
    todos.refresh();
  }

  void undoDone(int index) {
    todos[index].isDone = false;
    todos.refresh();
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
  }


  List<TodoModel> get pendingTodos =>
      todos.where((todo) => !todo.isDone).toList();


  List<TodoModel> get completedTodos =>
      todos.where((todo) => todo.isDone).toList();
}
