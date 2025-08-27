import 'package:learning_flutter/flutter/design_principles/dependency_injection/todo_list.dart';
import 'package:learning_flutter/flutter/design_principles/dependency_injection/todo_service.dart';

class TodoRepository {
  static final _service = TodoService();
  static final _todoListModel = TodoListModel(_service);
  static TodoListModel get todoListModel => _todoListModel;
}
