import 'package:flutter/material.dart';
import 'package:susc_2023s_todo_example/page/add_todo.page.dart';
import 'package:susc_2023s_todo_example/page/edit_todo.page.dart';
import 'package:susc_2023s_todo_example/page/list_todo.page.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      initialRoute: '/',
      routes: {
        '/': (context) => const ListTodoPage(),
        '/add': (context) => const AddTodoPage(),
        '/edit': (context) => const EditTodoPage(),
      },
    );
  }
}
