import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_for_riverpod/pages/providers/theme/theme_provider.dart';
import 'package:todo_list_for_riverpod/pages/providers/theme/theme_state.dart';
import 'package:todo_list_for_riverpod/repositories/hive_todos_repository.dart';
import 'package:todo_list_for_riverpod/repositories/providers/todos_repository_provider.dart';

import 'pages/todos_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todos');

  runApp(
    ProviderScope(
      overrides: [
        // 这里对请求方法重写，应该是这样可以在请求类里使用ref
        todosRepositoryProvider.overrideWithValue(HiveTodosRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Todos',
      debugShowCheckedModeBanner: false,
      // theme: currentTheme == AppTheme.light
      //     ? ThemeData.light(useMaterial3: true)
      //     : ThemeData.dark(useMaterial3: true),
      theme: switch (currentTheme) {
        LightTheme() => ThemeData.light(useMaterial3: true),
        DarkTheme() => ThemeData.dark(useMaterial3: true),
      },
      home: const TodosPage(),
    );
  }
}
