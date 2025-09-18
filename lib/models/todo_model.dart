class TodoModel {
  String title;
  String description;
  String urgency;   // Work / Study / Personal
  String category;  // Low / Medium / High
  bool isDone;
  String dueDate;

  TodoModel({
    required this.title,
    required this.description,
    required this.urgency,   // dropdown
    required this.category,  // urgency buttons
    this.isDone = false,
    this.dueDate = "",
  });
}
