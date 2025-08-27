import 'package:floor/floor.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor/todo.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM todo')
  Future<List<Todo>> getAllTodos();

  @Query('SELECT * FROM todo WHERE id = :id')
  Future<Todo?> findTodoById(int id);

  @insert
  Future<int> insertTodo(Todo todo);

  @update
  Future<int> updateTodo(Todo todo);

  @delete
  Future<int> deleteTodo(Todo todo);
}
