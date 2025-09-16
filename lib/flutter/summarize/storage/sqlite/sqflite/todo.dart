class Todo {
  final int id;
  final String title;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'isDone': isDone ? 1 : 0,
  };

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
    id: map['id'] as int,
    title: map['title'] as String,
    isDone: map['isDone'] == 1 ? true : false,
  );
}
