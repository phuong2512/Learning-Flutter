import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Todo>> watchTodos(String searchQuery) {
    return (select(todos)
      ..where((tbl) => tbl.title.contains(searchQuery.toLowerCase()))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .watch();
  }

  Future<void> addTodo(String title, String? description) async {
    await into(todos).insert(TodosCompanion.insert(
      title: title,
      description: Value(description),
    ));
  }

  Future<int> deleteTodoById(int id) =>
      (delete(todos)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> toggleTodoCompleted(int id, bool isCompleted) async {
    await (update(todos)..where((tbl) => tbl.id.equals(id)))
        .write(TodosCompanion(isCompleted: Value(isCompleted)));
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      return driftDatabase(
        name: 'todo_database',
        native: DriftNativeOptions(
          databaseDirectory: getApplicationDocumentsDirectory,
        ),
      );
    });
  }
}