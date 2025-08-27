import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/storage/sqlite/sqflite/database_helper.dart';
import 'package:learning_flutter/flutter/storage/sqlite/sqflite/todo.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _controller = TextEditingController();
  List<Todo> _todos = [];
  final _dbHelper = DatabaseHelper.instance;
  bool _isDisconnected = false;

  @override
  void initState() {
    super.initState();
    _loadDatabase();
  }

  void _loadDatabase() async {
    final todos = await _dbHelper.getTodos();
    setState(() {
      _todos = todos;
      _isDisconnected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(onPressed: _killDB, icon: const Icon(Icons.delete_forever)),
          IconButton(onPressed: _filterDoneTask, icon: const Icon(Icons.done_all)),
          IconButton(onPressed: _deleteCompletedTodos, icon: const Icon(Icons.delete)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'New Todo',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      disabledColor: Colors.grey,
                      onPressed: _isDisconnected ? null : _addTodo,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _isDisconnected
                ? const Center(
                    child: Text(
                      'Database is disconnected',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  )
                : ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];
                      return ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (value) => _toggleTodo(todo),
                        ),
                        title: Text(todo.title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _updateTodo(todo),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteTodo(todo.id!),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMultipleTodos,
        child: const Icon(Icons.add_box),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _dbHelper.close();
    super.dispose();
  }

  void _addTodo() async {
    final todo = Todo(title: _controller.text);
    await _dbHelper.insertTodo(todo);
    _controller.clear();
    _loadDatabase();
  }

  void _deleteTodo(int id) async {
    // await _dbHelper.deleteTodo(id);
    await _dbHelper.deleteTodoByRawSQL(id);
    _loadDatabase();
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
              await _dbHelper.updateTodo(
                Todo(id: todo.id, title: newToDoTitle),
              );
              if (!context.mounted) return;
              _loadDatabase();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _toggleTodo(todo) {
    final isDone = !todo.isDone;
    _dbHelper.updateTodo(Todo(id: todo.id, title: todo.title, isDone: isDone));
    _loadDatabase();
  }

  void _killDB() {
    _dbHelper.killDatabase();
    setState(() {
      _todos = [];
      _isDisconnected = true;
    });
  }

  void _filterDoneTask() async {
    final filterTask = await _dbHelper.getCompletedTodos();
    setState(()  {
      _todos = filterTask;
    });
  }

  void _deleteCompletedTodos() async{
    final deletedCount = await _dbHelper.deleteCompletedTodosTransaction();
    if (deletedCount > 0) {
      _loadDatabase();
    }
  }

  void _addMultipleTodos() async {
    final newTodos = [
      Todo(title: 'Task 1'),
      Todo(title: 'Task 2'),
      Todo(title: 'Task 3'),
    ];
    await _dbHelper.insertTodosBatch(newTodos);
    _loadDatabase();
  }

}

