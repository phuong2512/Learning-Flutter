import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/design_principles/dependency_injection/todo.dart';
import 'package:learning_flutter/flutter/design_principles/dependency_injection/todo_service.dart';

class TodoListModel extends ChangeNotifier {
  final TodoService _service;
  final List<Todo> _todos = [];

  TodoListModel(this._service) {
    _todos.addAll(_service.getTodos());
  }

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    final newTodo = Todo(title: title);
    _todos.add(newTodo);
    _service.saveTodo(newTodo);
    notifyListeners();
  }

  void toggleTodoStatus(int index) {
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }
}