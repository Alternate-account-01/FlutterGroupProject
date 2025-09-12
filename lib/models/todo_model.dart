class TodoModel {
  String title;
  String description;
  String category;
  bool isDone;
  String dueDate; // ✅ new

  TodoModel({
    required this.title,
    required this.description,
    required this.category,
    this.isDone = false,
    this.dueDate = "", // default empty
  });
}
