class TodoModel {
  String title;
  String description;
  String category;
  bool isDone;
  String dueDate; 

  TodoModel({
    required this.title,
    required this.description,
    required this.category,
    this.isDone = false,
    this.dueDate = "", 
  });
}
