import 'package:bloktudo/services/todo_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionConteroller = TextEditingController();
  TodoBloc() : super(TodoLoading()) {
    on<FetchTodos>(_onFetchTodos);
    on<AddTodo>(_onAddTodo);
    on<Updatetodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<SubmitTodo>(_onSubmitTodo);
   
  
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await TodoServices.fetchTodo();
      if (todos != null) {
        emit(TodoLoaded(todos));
      } else {
        emit(const TodoError("Failed to fetch todos."));
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    try {
      final isSuccess = await TodoServices.addTodo(event.body);
      if (isSuccess) {
        add(FetchTodos());
      } else {
        emit(const TodoError("Failed to add todo."));
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onUpdateTodo(Updatetodo event, Emitter<TodoState> emit) async {
    try {
      final isSuccess = await TodoServices.updateTodo(event.id, event.body);
      if (isSuccess) {
        add(FetchTodos());
      } else {
        emit(const TodoError("Failed to update todo."));
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      final isSuccess = await TodoServices.deleteById(event.id);
      
      if (isSuccess) {
        add(FetchTodos()); 
      } else {
        emit(const TodoError("Failed to delete todo.")); 
      }
    } catch (e) {
      emit(TodoError(e.toString())); 
      print('Delete Error: $e'); 
    }
  }
  Future<void> _onSubmitTodo(SubmitTodo event, Emitter<TodoState> emit) async {
    try {
      final isSuccess = await TodoServices.addTodo(event.todo);
      if (isSuccess) {
        titleController.clear();
        descriptionConteroller.clear();
        emit(TodoSuccess(message: "Todo submitted successfully."));
        add(FetchTodos());
      } else {
        emit(const TodoError("Failed to submit todo."));
        
      }
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
   
}
