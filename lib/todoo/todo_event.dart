
import 'package:equatable/equatable.dart';




abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}
class FetchTodos extends TodoEvent {}

class Updatetodo extends TodoEvent{
  final String id;
  final Map<String,dynamic> body;

  const Updatetodo(  
   this.body, 
   this.id);
  
  
  

}
class DeleteTodo extends TodoEvent{
  final String id;


  const DeleteTodo(this.id);

}

class AddTodo extends TodoEvent{
  final Map<String, dynamic> body;



  const AddTodo(  this.body);
  }
  class SubmitTodo extends TodoEvent {
  final Map<String, dynamic> todo;

  const SubmitTodo(this.todo);

}
class UpdateData extends TodoEvent {
  final String id;
  final Map<String, dynamic> updateData;

  const UpdateData(this.id, this.updateData);

 
}