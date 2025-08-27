import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor_and_sqflite/todo.dart';
class RawQueryService {
  static Database? _db;

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'app_database.db');
    _db = await openDatabase(path);
    return _db!;
  }

  // Lấy tất cả todos đã hoàn thành
  static Future<List<Todo>> getCompletedTodos() async {
    final db = await getDatabase();
    final result =
    await db.query('todos', where: 'isDone = ?', whereArgs: [1]);
    return result.map((e) => Todo.fromMap(e)).toList();
  }

  // Xóa tất cả todos chưa hoàn thành
  static Future<int> deleteIncompleteTodos() async {
    final db = await getDatabase();
    return await db.delete('todos', where: 'isDone = ?', whereArgs: [0]);
  }
}
