import 'package:flutter/material.dart';
import 'package:susc_2023s_todo_example/model/todo.repository.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> addTodo(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      await TodoRepository.instance.createTodo(
          title: titleController.text,
          description: descriptionController.text,
          date: DateTime.parse(dateController.text));

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('해야 할 일 추가'),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('제목'),
                      TextFormField(
                        controller: titleController,
                        maxLength: 30,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '제목을 입력해주세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('설명'),
                      TextFormField(
                        controller: descriptionController,
                        maxLength: 100,
                      ),
                      const SizedBox(height: 16),
                      const Text('날짜'),
                      TextFormField(
                          controller: dateController,
                          decoration: const InputDecoration(
                              labelText: 'YYYY-MM-DD 형식으로 입력해주세요.'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '날짜를 입력해주세요.';
                            }

                            DateTime? parsedDate = DateTime.tryParse(value);
                            if (parsedDate == null) {
                              return '잘못된 형식입니다.';
                            }

                            return null;
                          }),
                      const SizedBox(height: 32),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () => addTodo(context),
                              child: const Text('추가')))
                    ],
                  ),
                ))));
  }
}
