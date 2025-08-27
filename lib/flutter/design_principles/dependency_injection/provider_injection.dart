import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learning_flutter/flutter/design_principles/dependency_injection/todo_list.dart';
import 'package:learning_flutter/flutter/design_principles/dependency_injection/todo_repository.dart';

void main() {
  final todoListModel = TodoRepository.todoListModel;

  runApp(MyApp(todoListModel: todoListModel));
}

class MyApp extends StatelessWidget {
  final TodoListModel todoListModel;

  const MyApp({required this.todoListModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => todoListModel,
      child: MaterialApp(home: TodoListScreen()),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoListModel = Provider.of<TodoListModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List (DI with Provider)')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todoListModel.todos.length,
              itemBuilder: (context, index) {
                final todo = todoListModel.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      todoListModel.toggleTodoStatus(index);
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
                      todoListModel.addTodo(_controller.text);
                      _controller.clear();
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
