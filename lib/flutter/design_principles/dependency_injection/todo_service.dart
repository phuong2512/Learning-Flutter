import 'package:learning_flutter/flutter/design_principles/dependency_injection/todo.dart';

class TodoService {
  List<Todo> getTodos() {
    return [Todo(title: 'Mua sữa'), Todo(title: 'Tập thể dục')];
  }

  void saveTodo(Todo todo) {
    print('Saving todo: ${todo.title}');
  }
}