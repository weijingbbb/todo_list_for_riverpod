// 实现请求
import 'dart:math';

import 'package:todo_list_for_riverpod/models/todo_model.dart';
import 'package:todo_list_for_riverpod/repositories/todos_repository.dart';

final initialTodos = [
  {"id": "1", "desc": "Clean the room", "completed": false},
  {"id": "2", "desc": "Wash the dish", "completed": false},
  {"id": "3", "desc": "Do homework", "completed": false},
];

const double kProbabiltyOfError = 0.5;
const int kDelayDuration = 1;

class FakeRepositoryProvider extends TodosRepository {
  List<Map<String, dynamic>> fakeTodos = initialTodos;
  final Random random = Random();

  Future<void> waitSeconds() {
    return Future.delayed(Duration(seconds: kDelayDuration));
  }

  @override
  Future<List<Todo>> getTodos() async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw '无法检索待办事项';
      }

      return [for (final todo in fakeTodos) Todo.fromJson(todo)];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTodo({required Todo todo}) async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw '添加失败';
      }
      fakeTodos = [...fakeTodos, todo.toJson()];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTodo({required String id, required String desc}) async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw '修改失败';
      }

      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] == id)
            {'id': id, 'desc': desc, 'completed': todo['completed']}
          else
            todo
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required String id}) async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw '移除失败';
      }

      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] != id) todo
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleTodo({required String id}) async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabiltyOfError) {
        throw 'Fail to toggle todo';
      }

      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] == id)
            {'id': id, 'desc': todo['desc'], 'completed': !todo['completed']}
          else
            todo,
      ];
    } catch (e) {
      rethrow;
    }
  }
}
