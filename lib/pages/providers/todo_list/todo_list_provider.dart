import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list_for_riverpod/models/todo_model.dart';
import 'package:todo_list_for_riverpod/repositories/providers/todos_repository_provider.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  FutureOr<List<Todo>> build() {
    print('[todoListProvider] 初始化');
    ref.onDispose(() {
      print('[todoListProvider] 销毁');
    });
    return _getTodos();
  }

  Future<List<Todo>> _getTodos() {
    return ref.read(todosRepositoryProvider).getTodos();
  }

  Future<void> addTodo(String desc) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newTodo = Todo.add(desc: desc);

      await ref.read(todosRepositoryProvider).addTodo(todo: newTodo);

      return [...state.value!, newTodo];
    });
  }

  Future<void> editTodo(String id, String desc) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(todosRepositoryProvider).editTodo(id: id, desc: desc);

      return [
        for (final todo in state.value!)
          if (todo.id == id) todo.copyWith(desc: desc) else todo
      ];
    });
  }

  Future<void> toggleTodo(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(todosRepositoryProvider).toggleTodo(id: id);

      return [
        for (final todo in state.value!)
          if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo
      ];
    });
  }

  Future<void> removeTodo(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(todosRepositoryProvider).removeTodo(id: id);

      return [
        for (final todo in state.value!)
          if (todo.id != id) todo
      ];
    });
  }
}



// @riverpod
// class TodoList extends _$TodoList {
//   List<Todo> _todos = [];

//   @override
//   TodoListState build() {
//     return const TodoListStateInitial();
//   }

//   Future<void> getTodos() async {
//     state = const TodoListStateLoading();
//     try {
//       _todos = await ref.read(todosRepositoryProvider).getTodos();
//       state = TodoListStateSuccess(todos: _todos);
//     } catch (e) {
//       state = TodoListStateFailure(error: e.toString());
//     }
//     // state = const TodoListStateInitial();
//     // state = state.copyWith(status: TodoListStatus.loading);

//     // try {
//     //   final todos = await ref.read(todosRepositoryProvider).getTodos();

//     //   state = state.copyWith(
//     //     status: TodoListStatus.success,
//     //     todos: todos,
//     //   );
//     // } catch (e) {
//     //   state = state.copyWith(
//     //     status: TodoListStatus.failure,
//     //     error: e.toString(),
//     //   );
//     // }
//   }

//   Future<void> addTodo(String desc) async {
//     state = const TodoListStateLoading();
//     try {
//       final newTodo = Todo.add(desc: desc);
//       await ref.read(todosRepositoryProvider).addTodo(todo: newTodo);
//       _todos = [..._todos, newTodo];
//       state = TodoListStateSuccess(todos: _todos);
//     } catch (e) {
//       state = TodoListStateFailure(error: e.toString());
//     }
//     // state = state.copyWith(status: TodoListStatus.loading);
//     // try {
//     //   final newTodo = Todo.add(desc: desc);
//     //   await ref.read(todosRepositoryProvider).addTodo(todo: newTodo);
//     //   state = state.copyWith(
//     //     status: TodoListStatus.success,
//     //     todos: [...state.todos, newTodo],
//     //   );
//     // } catch (e) {
//     //   state = state.copyWith(
//     //     status: TodoListStatus.failure,
//     //     error: e.toString(),
//     //   );
//     // }
//   }

//   Future<void> editTodo(String id, String desc) async {
//     state = const TodoListStateLoading();

//     try {
//       await ref.read(todosRepositoryProvider).editTodo(id: id, desc: desc);

//       _todos = [
//         for (final todo in _todos)
//           if (todo.id == id) todo.copyWith(desc: desc) else todo
//       ];

//       state = TodoListStateSuccess(todos: _todos);
//     } catch (e) {
//       state = TodoListStateFailure(error: e.toString());
//     }
//     // state = state.copyWith(status: TodoListStatus.loading);
//     // try {
//     //   await ref.read(todosRepositoryProvider).editTodo(id: id, desc: desc);
//     //   state = state.copyWith(
//     //     status: TodoListStatus.success,
//     //     todos: [
//     //       for (final todo in state.todos)
//     //         if (todo.id == id) todo.copyWith(desc: desc) else todo
//     //     ],
//     //   );
//     // } catch (e) {
//     //   state = state.copyWith(
//     //     status: TodoListStatus.failure,
//     //     error: e.toString(),
//     //   );
//     // }
//   }

//   Future<void> toggleTodo(String id) async {
//     state = const TodoListStateLoading();

//     try {
//       await ref.read(todosRepositoryProvider).toggleTodo(id: id);

//       _todos = [
//         for (final todo in _todos)
//           if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo
//       ];

//       state = TodoListStateSuccess(todos: _todos);
//     } catch (e) {
//       state = TodoListStateFailure(error: e.toString());
//     }
//     // state = state.copyWith(status: TodoListStatus.loading);
//     // try {
//     //   await ref.read(todosRepositoryProvider).toggleTodo(id: id);
//     //   state = state.copyWith(
//     //     status: TodoListStatus.success,
//     //     todos: [
//     //       for (final todo in state.todos)
//     //         if (todo.id == id)
//     //           todo.copyWith(completed: !todo.completed)
//     //         else
//     //           todo
//     //     ],
//     //   );
//     // } catch (e) {
//     //   state = state.copyWith(
//     //     status: TodoListStatus.failure,
//     //     error: e.toString(),
//     //   );
//     // }
//   }

//   Future<void> removeTodo(String id) async {
//     state = const TodoListStateLoading();

//     try {
//       await ref.read(todosRepositoryProvider).removeTodo(id: id);

//       _todos = [
//         for (final todo in _todos)
//           if (todo.id != id) todo
//       ];

//       state = TodoListStateSuccess(todos: _todos);
//     } catch (e) {
//       state = TodoListStateFailure(error: e.toString());
//     }
//     // state = state.copyWith(status: TodoListStatus.loading);
//     // try {
//     //   await ref.read(todosRepositoryProvider).removeTodo(id: id);
//     //   state = state.copyWith(
//     //     status: TodoListStatus.success,
//     //     todos: [
//     //       for (final todo in state.todos)
//     //         if (todo.id != id) todo
//     //     ],
//     //   );
//     // } catch (e) {
//     //   state = state.copyWith(
//     //     status: TodoListStatus.failure,
//     //     error: e.toString(),
//     //   );
//     // }
//   }
// }
