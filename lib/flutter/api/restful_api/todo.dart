class Todo {
  final int? id;
  final int userId;
  final String todo;
  final bool completed;

  Todo({
    this.id,
    required this.userId,
    required this.todo,
    this.completed = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'],
    userId: json['userId'],
    todo: json['todo'],
    completed: json['completed'] as bool,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "todo": todo,
    "completed": completed,
  };
}
