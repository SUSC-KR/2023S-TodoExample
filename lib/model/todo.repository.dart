import 'package:shared_preferences/shared_preferences.dart';
import 'package:susc_2023s_todo_example/model/todo.dart';
import 'package:susc_2023s_todo_example/model/todo.mapper.dart';

class TodoRepository {
  static final TodoRepository instance = TodoRepository();

  Future<List<Todo>> listTodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = prefs.getStringList('todoList') ?? [];
    List<Todo> mappedTodoList =
        todoList.map((e) => TodoMapper.fromJson(e)).toList();
    mappedTodoList.sort((a, b) => a.date.compareTo(b.date));
    return mappedTodoList;
  }

  Future<Todo> createTodo(Todo todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = prefs.getStringList('todoList') ?? [];

    todoList.add(TodoMapper.toJson(todo));
    await prefs.setStringList('todoList', todoList);

    return todo;
  }

  Future<Todo> editTodo({
    required int id,
    required String title,
    required String description,
    required DateTime date,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = prefs.getStringList('todoList') ?? [];

    Todo newTodo = Todo(
      id: id,
      title: title,
      description: description,
      date: date,
    );

    todoList.removeWhere((element) => TodoMapper.fromJson(element).id == id);
    todoList.add(TodoMapper.toJson(newTodo));

    await prefs.setStringList('todoList', todoList);
    return newTodo;
  }

  Future<void> deleteTodo({
    required int id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = prefs.getStringList('todoList') ?? [];

    todoList.removeWhere((element) => TodoMapper.fromJson(element).id == id);

    await prefs.setStringList('todoList', todoList);
  }
}
