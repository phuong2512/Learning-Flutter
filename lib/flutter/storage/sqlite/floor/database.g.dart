// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `isDone` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _todoInsertionAdapter = InsertionAdapter(
            database,
            'todo',
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isDone': item.isDone ? 1 : 0
                }),
        _todoUpdateAdapter = UpdateAdapter(
            database,
            'todo',
            ['id'],
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isDone': item.isDone ? 1 : 0
                }),
        _todoDeletionAdapter = DeletionAdapter(
            database,
            'todo',
            ['id'],
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isDone': item.isDone ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Todo> _todoInsertionAdapter;

  final UpdateAdapter<Todo> _todoUpdateAdapter;

  final DeletionAdapter<Todo> _todoDeletionAdapter;

  @override
  Future<List<Todo>> getAllTodos() async {
    return _queryAdapter.queryList('SELECT * FROM todo',
        mapper: (Map<String, Object?> row) => Todo(
            id: row['id'] as int?,
            title: row['title'] as String,
            isDone: (row['isDone'] as int) != 0));
  }

  @override
  Future<Todo?> findTodoById(int id) async {
    return _queryAdapter.query('SELECT * FROM todo WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Todo(
            id: row['id'] as int?,
            title: row['title'] as String,
            isDone: (row['isDone'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<int> insertTodo(Todo todo) {
    return _todoInsertionAdapter.insertAndReturnId(
        todo, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateTodo(Todo todo) {
    return _todoUpdateAdapter.updateAndReturnChangedRows(
        todo, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteTodo(Todo todo) {
    return _todoDeletionAdapter.deleteAndReturnChangedRows(todo);
  }
}
