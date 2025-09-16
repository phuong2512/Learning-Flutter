import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/api/restful_api/todo.dart';
import 'package:learning_flutter/flutter/api/restful_api/dio/api_dio_service.dart';

class RestfulApiDioDemo extends StatefulWidget {
  const RestfulApiDioDemo({super.key});

  @override
  State<RestfulApiDioDemo> createState() => _RestfulApiDioDemoState();
}

class _RestfulApiDioDemoState extends State<RestfulApiDioDemo> {
  final ApiDioService _apiDioService = ApiDioService();
  final TextEditingController _idController = TextEditingController();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final data = await _apiDioService.getTodos();
    setState(() => todos = data.take(10).toList());
  }

  void _getTodoById(String id) async {
    final todo = await _apiDioService.getTodoById(int.parse(id));
    setState(() => todos = [todo]);
  }

  void _createNewTodo() async {
    final todo = Todo(userId: 1, todo: "New Dio task");
    final created = await _apiDioService.createTodo(todo);
    setState(() => todos.add(created));
    log("Create Dio Todo with id ${created.id}");
  }

  void _updateTodo(int index) async {
    if (todos.isEmpty) return;
    final todo = todos[index];
    final updated = await _apiDioService.updateTodo(
      Todo(
        id: todo.id,
        userId: todo.userId,
        todo: "Updated task",
        completed: true,
      ),
    );
    setState(() => todos[index] = updated);
    log("Update Dio Todo at index $index with id ${updated.id}");
  }

  void _patchTodo(int index) async {
    if (todos.isEmpty) return;
    final todo = todos[index];
    final patched = await _apiDioService.patchTodo(todo.id!, {
      "completed": true,
    });
    setState(() => todos[index] = patched);
    log("Patch Dio Todo at index $index with id ${patched.id}");
  }

  void _deleteTodo(int index) async {
    if (todos.isEmpty) return;
    final todo = todos[index];
    await _apiDioService.deleteTodo(todo.id!);
    setState(() => todos.removeAt(index));
    log("Del Dio Todo at index $index with id ${todo.id!}");
  }

  void _refresh() {
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: _refresh, icon: Icon(Icons.refresh)),
                  Expanded(
                    child: TextField(
                      controller: _idController,
                      decoration: const InputDecoration(
                        labelText: "Todo Id",
                        hintText: "Enter todo id",
                      ),
                      onSubmitted: (value) async => _getTodoById(value),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (_, index) => ListTile(
                    leading: IconButton(
                      onPressed: () => _patchTodo(index),
                      icon: Icon(
                        todos[index].completed
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                      ),
                    ),
                    title: Text("${todos[index].id} - ${todos[index].todo}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _updateTodo(index),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => _deleteTodo(index),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
