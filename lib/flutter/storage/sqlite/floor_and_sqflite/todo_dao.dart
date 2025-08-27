import 'package:floor/floor.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor_and_sqflite/todo.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM todo')
  Future<List<Todo>> getAllTodos();

  @insert
  Future<int> insertTodo(Todo todo);

  @update
  Future<int> updateTodo(Todo todo);

  @delete
  Future<int> deleteTodo(Todo todo);
}
