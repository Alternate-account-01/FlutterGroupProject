class TodoModel {
  String title;
  String description;
  String urgency; 
  String category; 
  bool isDone;
  String dueDate;

  TodoModel({
    required this.title,
    required this.description,
    required this.urgency,  
    required this.category,  
    this.isDone = false,
    this.dueDate = "",
  });
}
