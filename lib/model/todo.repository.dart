import 'package:shared_preferences/shared_preferences.dart';
import 'package:susc_2023s_todo_example/model/todo.dart';
import 'package:susc_2023s_todo_example/model/todo.mapper.dart';

class TodoRepository {
  static final TodoRepository instance = TodoRepository();

  int nextId() {
    // id를 unix timestamp로 생성
    return DateTime.now().millisecondsSinceEpoch;
  }

  Future<List<Todo>> listTodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = prefs.getStringList('todoList') ?? [];
    return todoList.map((e) => TodoMapper.fromJson(e)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  Future<Todo?> getTodoById({
    required int id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> rawTodoList = prefs.getStringList('todoList') ?? [];
    List<Todo> todoList =
        rawTodoList.map((e) => TodoMapper.fromJson(e)).toList();

    for (Todo todo in todoList) {
      if (todo.id == id) {
        return todo;
      }
    }

    return null;
  }

  Future<Todo> createTodo({
    required String title,
    required String description,
    required DateTime date,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = prefs.getStringList('todoList') ?? [];

    Todo todo = Todo(
      id: nextId(),
      title: title,
      description: description,
      date: date,
    );

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
