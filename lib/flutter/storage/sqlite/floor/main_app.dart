import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor/database.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor/todo.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor/todo_dao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase
      .databaseBuilder('todo_database.db')
      .build();

  final todoDao = database.todoDao;

  runApp(MyApp(todoDao: todoDao));
}

class MyApp extends StatelessWidget {
  final TodoDao todoDao;

  const MyApp({super.key, required this.todoDao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoScreen(todoDao: todoDao));
  }
}

class TodoScreen extends StatefulWidget {
  final TodoDao todoDao;

  const TodoScreen({super.key, required this.todoDao});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    todos = await widget.todoDao.getAllTodos();
    setState(() {});
  }

  Future<void> _addTodo() async {
    final newTodo = Todo(title: 'New Task');
    await widget.todoDao.insertTodo(newTodo);
    _loadTodos();
  }

  Future<void> _deleteTodo(Todo todo) async {
    await widget.todoDao.deleteTodo(todo);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Floor Example')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text("${todo.title} - ${todo.id}"),
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (val) async {
                await widget.todoDao.updateTodo(
                  Todo(id: todo.id, title: todo.title, isDone: val ?? false),
                );
                _loadTodos();
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _deleteTodo(todo),
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () => _updateTodo(todo),
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
            onLongPress: () async {
              await widget.todoDao.deleteTodo(todo);
              _loadTodos();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _updateTodo(Todo todo) {
    final controller = TextEditingController(text: todo.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Todo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'New Todo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final newToDoTitle = controller.text;
              await widget.todoDao.updateTodo(
                Todo(id: todo.id, title: newToDoTitle),
              );
              if (!context.mounted) return;
              _loadTodos();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
