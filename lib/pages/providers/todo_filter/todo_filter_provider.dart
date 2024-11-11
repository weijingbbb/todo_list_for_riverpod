import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list_for_riverpod/models/todo_model.dart';

part 'todo_filter_provider.g.dart';

@riverpod
class TodoFilter extends _$TodoFilter {
  @override
  build() {
    return Filter.all;
  }

  void changeFilter(Filter newFilter) {
    state = newFilter;
  }
}
