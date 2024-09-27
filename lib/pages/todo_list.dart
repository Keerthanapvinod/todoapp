import 'package:bloktudo/pages/add_todo.dart';
import 'package:bloktudo/todoo/todo_bloc.dart';
import 'package:bloktudo/todoo/todo_event.dart';
import 'package:bloktudo/todoo/todo_state.dart';
import 'package:bloktudo/widget/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TodoListPage extends StatelessWidget {
  bool isloding= true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc()..add(FetchTodos()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Todo List')),
        body: 
        BlocConsumer<TodoBloc, TodoState>(
           listener: (context, state) {
            if (state is TodoSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is TodoFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is TodoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('An error occurred: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state is TodoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodoLoaded) {
              final todos = state.todos;
              if (todos.isEmpty) {
                return const Center(
                  child: Text(
                    'No Todos Available.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return Visibility(
                visible: isloding,

                child: RefreshIndicator(
                  onRefresh: (
                    
                  ) async {
                    context.read<TodoBloc>().add(FetchTodos());
                  
                  },
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return TodoCard(
                        index: index,
                        item: todo,
                        deleteById: (id) {
                          context.read<TodoBloc>().add(DeleteTodo(id));
                        },
                        navigateEdit: (todo) async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTodoPage(todo: todo),
                            ),
                          );
                          context.read<TodoBloc>().add(FetchTodos());
                        },
                      );
                    },
                  ),
                ),
              );
            } else if (state is TodoError) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: Text('No Todos Available.'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AddTodoPage()),
            );
            context.read<TodoBloc>().add(FetchTodos());
          },
          label: const Text('Add Todo'),
        ),
      ),
    );
  }
}
