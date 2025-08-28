import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_flutter/flutter/storage/firebase/todo_controller.dart';
import 'package:learning_flutter/flutter/storage/firebase/todo.dart';
import 'package:learning_flutter/flutter/storage/firebase/todo_service.dart';

class TodoScreen extends StatefulWidget {
  final ShapeBorder? floatingActionButtonShape;

  const TodoScreen({super.key, required this.floatingActionButtonShape});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late final TodoController _todoController;

  @override
  void initState() {
    super.initState();
    _todoController = TodoController(TodoService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do'),
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: StreamBuilder<List<Todo>>(
        stream: _todoController.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('ADD SOME TASKS TO DO!'));
          }

          final todos = snapshot.data!;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 2,
                child: CheckboxListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: todo.isDone ? Colors.grey : null,
                    ),
                  ),
                  subtitle: Text(
                    todo.deadline == null
                        ? 'Deadline: none'
                        : 'Deadline: ${DateFormat('dd/MM/yyyy').format(
                        todo.deadline!)}',
                    style: TextStyle(
                      color:
                      (todo.deadline != null &&
                          todo.deadline!.isBefore(DateTime.now()))
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                  value: todo.isDone,
                  onChanged: (bool? value) {
                    if (value != null) {
                      _todoController.updateTodoStatus(todo.id, value);
                    }
                  },
                  secondary: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      _showDeleteConfirmationDialog(
                        context,
                        _todoController,
                        todo.id,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: widget.floatingActionButtonShape,
        onPressed: () {
          _showAddTodoDialog(context, _todoController);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, TodoController controller) {
    final TextEditingController titleController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    bool hasDeadline = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add new task to do'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    autofocus: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: hasDeadline,
                        onChanged: (bool? value) {
                          setState(() {
                            hasDeadline = value!;
                          });
                        },
                      ),
                      const Text("Pick a deadline?"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (hasDeadline)
                    Row(
                      children: [
                        const Text("Deadline: "),
                        Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      controller.addTodo(
                        titleController.text,
                        hasDeadline ? selectedDate : null,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context,
      TodoController controller,
      String todoId,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm deletion'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                controller.deleteTodo(todoId);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
