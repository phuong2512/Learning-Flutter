import 'package:dio/dio.dart';
import 'package:learning_flutter/flutter/api/restful_api/todo.dart';

class ApiDioService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com/todos",
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<Todo>> getTodos() async {
    final res = await _dio.get('');
    final List data = res.data['todos'];
    return data.map((e) => Todo.fromJson(e)).toList();
  }

  Future<Todo> getTodoById(int id) async {
    final res = await _dio.get("/todos/$id");
    if (res.statusCode == 200) {
      return Todo.fromJson(res.data);
    } else {
      throw Exception("Failed to fetch todo $id");
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    final res = await _dio.post(
      '/add',
      data: {"todo": todo.todo, "completed": false, "userId": todo.userId},
    );
    return Todo.fromJson(res.data);
  }

  Future<Todo> updateTodo(Todo todo) async {
    try {
      final res = await _dio.put(
        '/${todo.id}',
        data: {"todo": todo.todo, "completed": todo.completed},
      );
      return Todo.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception("Failed to update todo: ${e.response?.data}");
    }
  }

  Future<Todo> patchTodo(int id, Map<String, dynamic> fields) async {
    final res = await _dio.patch('/$id', data: fields);
    return Todo.fromJson(res.data);
  }

  Future<void> deleteTodo(int id) async {
    await _dio.delete('/$id');
  }
}
