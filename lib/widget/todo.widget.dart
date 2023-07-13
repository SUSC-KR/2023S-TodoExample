import 'package:flutter/material.dart';
import 'package:susc_2023s_todo_example/model/todo.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.description),
      trailing: Text(calculateDday()),
    );
  }

  String calculateDday() {
    DateTime now = DateTime.now();
    DateTime date = todo.date;

    int diff = date.difference(now).inDays;

    if (diff > 0) {
      return 'D-$diff';
    } else if (diff == 0) {
      return 'D-Day';
    } else {
      return 'D+${diff.abs()}';
    }
  }
}
