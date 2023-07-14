import 'package:flutter/material.dart';
import 'package:susc_2023s_todo_example/model/todo.dart';
import 'package:susc_2023s_todo_example/model/todo.repository.dart';

typedef RefreshCallback = void Function();

class TodoWidget extends StatelessWidget {
  final Todo todo;

  final RefreshCallback refresh;

  const TodoWidget({
    required this.todo,
    required this.refresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.description),
      trailing: Text(buildDdayString(),
          style:
              TextStyle(color: buildDdayColor(), fontWeight: FontWeight.bold)),
      onTap: () => showMenuBottomSheet(context),
    );
  }

  void showMenuBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('수정'),
              onTap: () async {
                await Navigator.pushNamed(context, '/edit', arguments: todo);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('삭제'),
              onTap: () async {
                await TodoRepository.instance.deleteTodo(id: todo.id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    refresh();
  }

  int calculateDiff() {
    DateTime now = DateTime.now();
    DateTime date = todo.date;

    return date.difference(now).inDays;
  }

  Color? buildDdayColor() {
    int diff = calculateDiff();

    if (diff < 0) {
      return Colors.green;
    } else if (diff == 0) {
      return Colors.red;
    } else if (diff <= 5) {
      return Colors.orange;
    }

    return null;
  }

  String buildDdayString() {
    int diff = calculateDiff();

    if (diff > 0) {
      return 'D-$diff';
    } else if (diff == 0) {
      return 'D-DAY';
    } else {
      return 'D+${diff.abs()}';
    }
  }
}
