import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_for_riverpod/pages/providers/todo_search/todo_search_provider.dart';

class SearchTodo extends ConsumerWidget {
  const SearchTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(
        labelText: '搜索 todos...',
        border: InputBorder.none,
        filled: true,
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (String? search) {
        if (search == null) return;
        ref.read(todoSearchProvider.notifier).setSearchTerm(search);
      },
    );
  }
}
