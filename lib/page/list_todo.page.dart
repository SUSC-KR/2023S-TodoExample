import 'package:flutter/material.dart';
import 'package:susc_2023s_todo_example/model/todo.dart';
import 'package:susc_2023s_todo_example/model/todo.repository.dart';
import 'package:susc_2023s_todo_example/page/add_todo.page.dart';
import 'package:susc_2023s_todo_example/page/edit_todo.page.dart';
import 'package:susc_2023s_todo_example/widget/todo.widget.dart';

class ListTodoPage extends StatefulWidget {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  State<ListTodoPage> createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodoPage> {
  List<Todo>? todos;

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  void loadTodos() async {
    final List<Todo> todos = await TodoRepository.instance.listTodo();

    setState(() {
      this.todos = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('해야 할 일'),
      ),
      body: buildList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onCreate(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void onCreate() async {
    Todo? newTodo = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodoPage()));
    if (newTodo != null) {
      await TodoRepository.instance.createTodo(newTodo);
      loadTodos();
    }
    loadTodos();
  }

  Widget buildList(BuildContext context) {
    if (todos == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (todos!.isEmpty) {
      return const Center(
        child: Text('해야 할 일이 없습니다.'),
      );
    }

    return ListView.builder(
      itemCount: todos!.length,
      itemBuilder: (context, index) => TodoWidget(
        todo: todos![index],
        onEdit: (todo) async {
          Todo? editedTodo = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditTodoPage(),
                  settings: RouteSettings(arguments: todo)));
          if (editedTodo != null) {
            await TodoRepository.instance.editTodo(
                id: editedTodo.id,
                title: editedTodo.title,
                description: editedTodo.description,
                date: editedTodo.date);
            loadTodos();
          }
        },
        onDelete: (todoId) {
          TodoRepository.instance.deleteTodo(id: todoId);
          loadTodos();
        },
      ),
    );
  }
}
