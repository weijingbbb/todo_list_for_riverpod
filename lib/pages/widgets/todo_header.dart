import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_for_riverpod/pages/providers/active_todo_count/active_todo_count_provider.dart';
import 'package:todo_list_for_riverpod/pages/providers/theme/theme_provider.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_list/todo_list_provider.dart';

class TodoHeader extends ConsumerWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(activeTodoCountProvider);
    final todos = ref.watch(todoListProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'TODO',
              style: TextStyle(fontSize: 36.0),
            ),
            const SizedBox(width: 10),
            Text(
              '($active/${todos.length} item${active != 1 ? "s" : ""} left)',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },
          icon: const Icon(Icons.light_mode),
        )
      ],
    );
  }
}
