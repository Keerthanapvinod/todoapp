
import 'package:bloktudo/todoo/todo_bloc.dart';
import 'package:bloktudo/todoo/todo_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoPage extends StatelessWidget {
  final Map? todo;
  
  AddTodoPage({super.key, this.todo});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isEdit = todo != null;

    if (isEdit) {
      titleController.text = todo!['title'] ?? '';
      descriptionController.text = todo!['description'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Todo' :'Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'Description'),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final body = {
                  'title': titleController.text,
                  'description': descriptionController.text,
                  'is_completed': false,
                };
        
                if (isEdit) {
                  final id = todo!['_id'];  
                  context.read<TodoBloc>().add(
                    Updatetodo(body,id),  
                  );
                } else {
                  context.read<TodoBloc>().add(
                    AddTodo(body),  
                  );
                }
                context.read<TodoBloc>().add(FetchTodos());
            Navigator.pop(context);  
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(isEdit ? 'Update' : 'Submit'),
            ),
          ],
        ),
      ),
    );
  }
  Map get body{
    final title = titleController.text;
  final description = descriptionController.text;
 return{
  "title": title,
  "description": description,
  "is_completed": false,

  };
  }
  
}
