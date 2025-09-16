import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/summarize/storage/sqlite/sqflite/database_service.dart';
import 'package:learning_flutter/flutter/summarize/storage/sqlite/sqflite/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SqfliteScreen());
  }
}

class SqfliteScreen extends StatefulWidget {
  const SqfliteScreen({super.key});

  @override
  State<SqfliteScreen> createState() => _SqfliteScreenState();
}

class _SqfliteScreenState extends State<SqfliteScreen> {
  late Future<List<Todo>> _todos;

  @override
  void initState() {
    super.initState();
    loadDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sqflite Demo'), centerTitle: true),
      body: SafeArea(child: Center()),
    );
  }

  Future<void> loadDatabase() async {
    setState(() {
      _todos = DatabaseService.instance.getTodos();
    });
  }
}
