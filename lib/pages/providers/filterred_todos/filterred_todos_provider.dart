import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list_for_riverpod/models/todo_model.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_filter/todo_filter_provider.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_list/todo_list_provider.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_search/todo_search_provider.dart';

part 'filterred_todos_provider.g.dart';

@riverpod
List<Todo> filterredTodos(Ref ref) {
  final todos = ref.watch(todoListProvider);
  final filter = ref.watch(todoFilterProvider);
  final search = ref.watch(todoSearchProvider);

  List<Todo> tempTodos;

  tempTodos = switch (filter) {
    Filter.active => todos.where((element) => !element.completed).toList(),
    Filter.completed => todos.where((element) => element.completed).toList(),
    Filter.all => todos,
    Object() => throw UnimplementedError(),
    null => throw UnimplementedError(),
  };

  if (search.isNotEmpty) {
    tempTodos = tempTodos
        .where((todo) => todo.desc.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  return tempTodos;
}
