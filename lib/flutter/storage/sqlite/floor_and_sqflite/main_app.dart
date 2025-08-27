import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor_and_sqflite/database.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor_and_sqflite/todo.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor_and_sqflite/todo_dao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late TodoDao _todoDao;
  late Future<List<Todo>> _todosFuture = Future.value([]);
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    _todoDao = database.todoDao;
    setState(() {
      _todosFuture = _todoDao.getAllTodos();
    });
  }

  Future<void> _addTodo() async {
    final title = _titleController.text;
    if (title.isNotEmpty) {
      final newTodo = Todo(title: title);
      await _todoDao.insertTodo(newTodo);
      _titleController.clear();
      _refreshTodos();
    }
  }

  Future<void> _toggleTodoStatus(Todo todo) async {
    final updatedTodo = Todo(
      id: todo.id,
      title: todo.title,
      isDone: !todo.isDone,
    );
    await _todoDao.updateTodo(updatedTodo);
    _refreshTodos();
  }

  Future<void> _deleteTodo(Todo todo) async {
    await _todoDao.deleteTodo(todo);
    _refreshTodos();
  }

  void _refreshTodos() {
    setState(() {
      _todosFuture = _todoDao.getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floor & Sqflite Todo App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'New Todo Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Todo>>(
              future: _todosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No todos found.'));
                }

                final todos = snapshot.data!;
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (bool? value) {
                          _toggleTodoStatus(todo);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTodo(todo),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}