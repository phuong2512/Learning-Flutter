import 'package:flutter/material.dart';
import 'database.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: TodoHomePage(database: AppDatabase()),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  final AppDatabase database;

  const TodoHomePage({super.key, required this.database});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    widget.database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search todos...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => searchQuery = '');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Todo>>(
              stream: widget.database.watchTodos(searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final todos = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (value) async {
                              await widget.database.toggleTodoCompleted(
                                todo.id,
                                value!,
                              );
                            },
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          subtitle: todo.description != null
                              ? Text(todo.description!)
                              : null,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await widget.database.deleteTodoById(todo.id);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('No todos found'));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter todo title',
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Enter description',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                await widget.database.addTodo(
                  titleController.text,
                  descriptionController.text.isNotEmpty
                      ? descriptionController.text
                      : null,
                );
                if (!context.mounted) return;
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
