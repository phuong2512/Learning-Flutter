import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/design_principles/dependency_injection/todo_list.dart';
import 'package:learning_flutter/flutter/design_principles/dependency_injection/todo_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListScreen(todoListModel: TodoRepository.todoListModel),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  final TodoListModel todoListModel;

  const TodoListScreen({required this.todoListModel, super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List (No DI)')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.todoListModel.todos.length,
              itemBuilder: (context, index) {
                final todo = widget.todoListModel.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      setState(() {});
                      widget.todoListModel.toggleTodoStatus(index);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Add a new todo',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      widget.todoListModel.addTodo(_controller.text);
                      _controller.clear();
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
