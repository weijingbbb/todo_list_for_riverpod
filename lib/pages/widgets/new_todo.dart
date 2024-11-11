import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_list/todo_list_provider.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_list/todo_list_state.dart';

class NewTodo extends ConsumerStatefulWidget {
  const NewTodo({super.key});

  @override
  ConsumerState<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends ConsumerState<NewTodo> {
  final _controller = TextEditingController();
  Widget prevWidget = const SizedBox.shrink();

  bool enableOrNot(TodoListStatus status) {
    switch (status) {
      case TodoListStatus.failure when prevWidget is SizedBox:
      case TodoListStatus.loading || TodoListStatus.initial:
        return false;
      case _:
        prevWidget = Container();
        return true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoListState = ref.watch(todoListProvider);
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(labelText: '添加新的TODO'),
      enabled: enableOrNot(todoListState.status),
      onSubmitted: (String? desc) {
        if (desc != null && desc.trim().isNotEmpty) {
          ref.read(todoListProvider.notifier).addTodo(desc);
          _controller.clear();
        }
      },
    );
  }
}
