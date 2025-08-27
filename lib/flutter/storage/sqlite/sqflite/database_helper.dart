import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:learning_flutter/flutter/storage/sqlite/sqflite/todo.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    log(dbPath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            isDone INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert('todos', todo.toMap());
  }

  Future<void> insertTodosBatch(List<Todo> todos) async {
    final db = await database;
    final batch = db.batch();
    for (var todo in todos) {
      batch.insert('todos', todo.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query('todos');
    return List.generate(maps.length, (i) => Todo.fromMap(maps[i]));
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  Future<void> killDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todos.db');
    await deleteDatabase(path);
  }

  Future<List<Todo>> getCompletedTodos() async {
    final db = await database;
    final maps = await db.query('todos', where: 'isDone = ?', whereArgs: [1]);
    return List.generate(maps.length, (i) => Todo.fromMap(maps[i]));
  }


  Future<void> deleteTodoByRawSQL(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM todos WHERE id = ?', [id]);
  }

  Future<int> deleteCompletedTodosTransaction() async {
    final db = await database;
    int deletedCount = 0;
    await db.transaction((txn) async {
      final completedTodos = await txn.query('todos', where: 'isDone = ?', whereArgs: [1]);
      if (completedTodos.isNotEmpty) {
        deletedCount = await txn.delete('todos', where: 'isDone = ?', whereArgs: [1]);
      }
    });
    return deletedCount;
  }
}
