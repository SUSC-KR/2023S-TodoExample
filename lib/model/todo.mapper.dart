import 'dart:convert';

import 'package:susc_2023s_todo_example/model/todo.dart';

class TodoMapper {
  static Todo fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);

    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
    );
  }

  static String toJson(Todo todo) {
    return jsonEncode({
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'date': todo.date.toIso8601String(),
    });
  }
}
