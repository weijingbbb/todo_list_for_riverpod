// 请求方法抽象类
import 'package:todo_list_for_riverpod/models/todo_model.dart';

abstract class TodosRepository {
  Future<List<Todo>> getTodos();
  Future<void> addTodo({required Todo todo});
  Future<void> editTodo({required String id, required String desc});
  Future<void> toggleTodo({required String id});
  Future<void> removeTodo({required String id});
}
