import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:learning_flutter/flutter/storage/sqlite/floor/todo.dart';
import 'package:learning_flutter/flutter/storage/sqlite/floor/todo_dao.dart';

part 'database.g.dart'; // Floor sẽ tự tạo file này

@Database(version: 1, entities: [Todo])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
