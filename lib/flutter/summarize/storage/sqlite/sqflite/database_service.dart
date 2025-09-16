import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:learning_flutter/flutter/summarize/storage/sqlite/sqflite/todo.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$filePath';
    return await openDatabase(path, version: 1, onCreate: _creatDB);
  }

  Future<void> _creatDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        isDone INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert('todos', todo.toMap());
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

  Future<void> closeDB() async {
    final db = await database;
    await db.close();
  }
}
