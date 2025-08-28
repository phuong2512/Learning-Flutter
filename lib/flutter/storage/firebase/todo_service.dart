import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_flutter/flutter/storage/firebase/todo.dart';

abstract class TodoRepository {
  Stream<List<Todo>> getTodos();
  Future<void> addTodo(String title, DateTime? deadline);
  Future<void> updateTodoStatus(String id, bool isDone);
  Future<void> deleteTodo(String id);
}

class TodoService implements TodoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'todos';

  @override
  Stream<List<Todo>> getTodos() {
    return _firestore.collection(_collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList();
    });
  }

  @override
  Future<void> addTodo(String title, DateTime? deadline) async {
    final Map<String, dynamic> data = {'title': title, 'isDone': false};
    if (deadline != null) {
      data['deadline'] = Timestamp.fromDate(deadline);
    }
    await _firestore.collection(_collectionName).add(data);
  }

  @override
  Future<void> updateTodoStatus(String id, bool isDone) async {
    await _firestore.collection(_collectionName).doc(id).update({
      'isDone': isDone,
    });
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _firestore.collection(_collectionName).doc(id).delete();
  }
}
