import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_for_riverpod/models/todo_model.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_filter/todo_filter_provider.dart';

class FilterTodo extends StatelessWidget {
  const FilterTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterButton(filter: Filter.all),
        FilterButton(filter: Filter.active),
        FilterButton(filter: Filter.completed),
      ],
    );
  }
}

class FilterButton extends ConsumerWidget {
  final Filter filter;
  const FilterButton({required this.filter, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(todoFilterProvider);

    return TextButton(
        onPressed: () {
          ref.read(todoFilterProvider.notifier).changeFilter(filter);
        },
        child: Text(
          filter == Filter.all
              ? '所有'
              : filter == Filter.active
                  ? '激活'
                  : '完成',
          style: TextStyle(
            fontSize: 18.0,
            color: currentFilter == filter ? Colors.blue : Colors.grey,
          ),
        ));
  }
}
