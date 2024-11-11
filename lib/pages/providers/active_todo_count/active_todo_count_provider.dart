import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_list/todo_list_provider.dart';

part 'active_todo_count_provider.g.dart';

@riverpod
int activeTodoCount(Ref ref) {
  return ref
      .watch(todoListProvider)
      .where((element) => !element.completed)
      .length;
}
