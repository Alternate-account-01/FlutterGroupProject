class TodoModel {
  String title;
  String description;
  String category;
  bool isDone;

  TodoModel({
    required this.title,
    required this.description,
    required this.category,
    this.isDone = false,
  });
}
