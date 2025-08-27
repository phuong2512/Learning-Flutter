import 'package:floor/floor.dart';

@Entity(tableName: 'todo')
class Todo {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final bool isDone;

  Todo({this.id, required this.title, this.isDone = false});
}
