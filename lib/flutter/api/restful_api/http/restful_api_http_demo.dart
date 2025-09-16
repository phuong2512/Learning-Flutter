import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/api/restful_api/http/api_http_service.dart';
import 'package:learning_flutter/flutter/api/restful_api/todo.dart';

class RestfulApiHttpDemo extends StatefulWidget {
  const RestfulApiHttpDemo({super.key});

  @override
  State<RestfulApiHttpDemo> createState() => _RestfulApiHttpDemoState();
}

class _RestfulApiHttpDemoState extends State<RestfulApiHttpDemo> {
  final ApiHttpService _apiHttpService = ApiHttpService();
  final TextEditingController _idController = TextEditingController();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final data = await _apiHttpService.getTodos();
    setState(() => todos = data.take(10).toList());
  }

  void _getTodoById(String id) async {
    final todo = await _apiHttpService.getTodoById(int.parse(id));
    setState(() {
      todos = [todo];
    });
  }

  void _createNewTodo() async {
    final todo = Todo(userId: 1, todo: "New task");
    final created = await _apiHttpService.createTodo(todo);
    setState(() => todos.add(created));
    log("Create New Todo with id ${created.id}");
  }

  void _updateTodo(int index) async {
    if (todos.isEmpty) return;
    final todo = todos[index];
    final updated = await _apiHttpService.updateTodo(
      Todo(
        id: todo.id,
        userId: todo.userId,
        todo: "Updated task",
        completed: true,
      ),
    );
    setState(() => todos[index] = updated);
    log("Update Todo at index $index with id ${updated.id}");
  }

  void _patchTodo(int index) async {
    if (todos.isEmpty) return;
    final todo = todos[index];
    final patched = await _apiHttpService.patchTodo(todo.id!, {
      "completed": true,
    });
    setState(() => todos[index] = patched);
    log("Path Todo at index $index with id ${patched.id}");
  }

  void _deleteTodo(int index) async {
    if (todos.isEmpty) return;
    final todo = todos[index];
    await _apiHttpService.deleteTodo(todo.id!);
    setState(() => todos.removeAt(index));
    log("Del Todo at index $index with id ${todo.id!}");
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
                      onSubmitted: (value) async {
                        _getTodoById(value);
                      },
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
