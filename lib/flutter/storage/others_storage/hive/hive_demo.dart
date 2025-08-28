import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learning_flutter/flutter/storage/others_storage/hive/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Khởi tạo Hive cho Flutter (hive_flutter)
  Hive.registerAdapter(TaskAdapter()); // Đăng ký adapter (hive_generator)
  await Hive.openBox<Task>('tasksBox');
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final _controller = TextEditingController();
  final _box = Hive.box<Task>('tasksBox');

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      final task = Task(title: _controller.text);
      _box.add(task); // Thêm task vào Box
      _controller.clear();
    }
  }

  void _deleteTask(int index) {
    _box.deleteAt(index); // Xóa task theo index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive To-Do List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter task title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _box.listenable(),
                builder: (context, Box<Task> box, _) {
                  if (box.isEmpty) {
                    return const Center(child: Text('No tasks yet!'));
                  }
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final task = box.getAt(index)!;
                      return ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            task.isCompleted = value ?? false;
                            task.save();
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(index),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}