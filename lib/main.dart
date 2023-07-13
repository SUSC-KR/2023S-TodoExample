import 'package:flutter/material.dart';
import 'package:susc_2023s_todo_example/page/list_todo.page.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '해야 할 일',
      home: ListTodoPage(),
    );
  }
}
