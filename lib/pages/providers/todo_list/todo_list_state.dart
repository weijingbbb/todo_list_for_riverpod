import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list_for_riverpod/models/todo_model.dart';

// part 'todo_list_state.freezed.dart';

// enum TodoListStatus {
//   initial,
//   loading,
//   success,
//   failure,
// }

// @freezed
// class TodoListState with _$TodoListState {
//   const factory TodoListState({
//     required TodoListStatus status,
//     required List<Todo> todos,
//     @Default('') String error,
//   }) = _TodoListState;

//   factory TodoListState.initial() => const TodoListState(
//         status: TodoListStatus.initial,
//         todos: [],
//       );
// }

// 使用密封类
sealed class TodoListState {
  const TodoListState();
}

// 初始状态
final class TodoListStateInitial extends TodoListState {
  const TodoListStateInitial() : super();

  @override
  String toString() => 'TodoListStateInitial()';
}

// 加载中
final class TodoListStateLoading extends TodoListState {
  const TodoListStateLoading() : super();

  @override
  String toString() => 'TodoListStateLoading()';
}
// 成功
final class TodoListStateSuccess extends TodoListState {
  final List<Todo> todos;

  const TodoListStateSuccess({
    required this.todos,
  }) : super();

  @override
  String toString() => 'TodoListStateSuccess(todos: $todos)';
}
// 失败
final class TodoListStateFailure extends TodoListState {
  final String error;

  const TodoListStateFailure({
    required this.error,
  }) : super();

  @override
  String toString() => 'TodoListStateFailure(error: $error)';
}
