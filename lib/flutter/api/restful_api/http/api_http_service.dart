import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_flutter/flutter/api/restful_api/todo.dart';

class ApiHttpService {
  static const baseUrl = "https://dummyjson.com/todos";
  final header = {"Content-Type": "application/json"};

  // GET
  Future<List<Todo>> getTodos() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body)['todos'];
      return data.map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch todos");
    }
  }


  // POST
  Future<Todo> createTodo(Todo todo) async {
    final res = await http.post(
      Uri.parse("$baseUrl/add"),
      body: jsonEncode({
        "todo": todo.todo,
        "completed": false,
        "userId": todo.userId,
      }),
      headers: header,
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      return Todo.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to create todo: ${res.body}");
    }
  }

  // PUT
  Future<Todo> updateTodo(Todo todo) async {
    final res = await http.put(
      Uri.parse("$baseUrl/${todo.id}"),
      body: jsonEncode({
        "todo": todo.todo,
        "completed": todo.completed,
      }),
      headers: header,
    );
    if (res.statusCode == 200) {
      return Todo.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to update todo: ${res.body}");
    }
  }

  // PATCH
  Future<Todo> patchTodo(int id, Map<String, dynamic> fields) async {
    final res = await http.patch(
      Uri.parse("$baseUrl/$id"),
      body: jsonEncode(fields),
      headers: header,
    );
    return Todo.fromJson(jsonDecode(res.body));
  }

  // DELETE
  Future<void> deleteTodo(int id) async {
    await http.delete(Uri.parse("$baseUrl/$id"));
  }

  Future<Todo> getTodoById(int id) async {
    final res = await http.get(Uri.parse("$baseUrl/$id"));
    if (res.statusCode == 200) {
      return Todo.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to fetch todo $id");
    }
  }
}
