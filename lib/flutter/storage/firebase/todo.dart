import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String title;
  final bool isDone;
  final DateTime? deadline;

  Todo({
    required this.id,
    required this.title,
    required this.isDone,
    this.deadline,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'deadline': deadline?.toIso8601String(),
    };
  }

  factory Todo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id,
      title: data['title'] ?? '',
      isDone: data['isDone'] ?? false,
      deadline: data['deadline']?.toDate(),
    );
  }

  @override
  String toString() {
    return 'Todo{title: $title, isDone: $isDone, deadline: $deadline}';
  }
}
