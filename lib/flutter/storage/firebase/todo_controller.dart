import 'package:learning_flutter/flutter/storage/firebase/todo.dart';
import 'package:learning_flutter/flutter/storage/firebase/todo_service.dart';

class TodoController {
  final TodoRepository _todoRepository;

  TodoController(this._todoRepository);

  Stream<List<Todo>> getTodos() => _todoRepository.getTodos();

  Future<void> addTodo(String title, DateTime? deadline) =>
      _todoRepository.addTodo(title, deadline);

  Future<void> updateTodoStatus(String id, bool isDone) async {
    await _todoRepository.updateTodoStatus(id, isDone);
  }

  Future<void> deleteTodo(String id) async {
    await _todoRepository.deleteTodo(id);
  }
}
