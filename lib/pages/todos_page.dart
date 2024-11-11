import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_list_for_riverpod/pages/widgets/filter_todo.dart';
import 'package:todo_list_for_riverpod/pages/widgets/new_todo.dart';
import 'package:todo_list_for_riverpod/pages/widgets/search_todo.dart';
import 'package:todo_list_for_riverpod/pages/widgets/show_todos.dart';
import 'package:todo_list_for_riverpod/pages/widgets/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: LoaderOverlay(
                overlayWidgetBuilder: (_) => const Center(
                      child: SpinKitFadingCube(
                        color: Colors.green,
                      ),
                    ),
                overlayColor: Colors.grey.withOpacity(0.4),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TodoHeader(),
                      NewTodo(),
                      SizedBox(height: 20),
                      SearchTodo(),
                      SizedBox(height: 10),
                      FilterTodo(),
                      SizedBox(height: 10),
                      Expanded(child: ShowTodos()),
                    ],
                  ),
                ))));
  }
}
