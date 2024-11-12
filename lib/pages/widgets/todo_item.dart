import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_for_riverpod/models/todo_model.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_item/todo_item_provider.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_list/todo_list_provider.dart';

class TodoItem extends ConsumerWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoItemProvider);
    print('TodoItem---------$todo');

    return ListTile(
      title: Text(todo.desc),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmEditDialog(todo);
          },
        );
      },
      leading: Checkbox(
          value: todo.completed,
          onChanged: (bool? checked) {
            ref.read(todoListProvider.notifier).toggleTodo(todo.id);
          }),
      trailing: IconButton(
          onPressed: () {
            dialog(context, ref, todo);
          },
          icon: const Icon(Icons.delete)),
    );
  }

  void dialog(BuildContext context, WidgetRef ref, Todo todo) async {
    final remove = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('删除'),
              content: const Text('确认删除吗？'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('确认')),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('取消'),
                )
              ]);
        });

    if (remove == true) {
      ref.read(todoListProvider.notifier).removeTodo(todo.id);
    }
  }
}

class ConfirmEditDialog extends ConsumerStatefulWidget {
  final Todo todo;
  const ConfirmEditDialog(this.todo, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmEditDialogState();
}

class _ConfirmEditDialogState extends ConsumerState<ConfirmEditDialog> {
  late final TextEditingController textController;
  bool error = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.todo.desc);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('编辑 Todo'),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: InputDecoration(
            errorText: error ? '不能为空' : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              error = textController.text.isEmpty;
              if (error) return;

              ref
                  .read(todoListProvider.notifier)
                  .editTodo(widget.todo.id, textController.text);
              Navigator.pop(context);
            },
            child: const Text('确认'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('取消'),
          ),
        ]);
  }
}
