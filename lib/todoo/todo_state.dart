import 'package:equatable/equatable.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List todos;
  const TodoLoaded(this.todos);
}

class TodoError extends TodoState {
  final String error;
  const TodoError(this.error);
}

class TodoSuccess extends TodoState {
  final String message;

  const TodoSuccess( { required this.message});

 
}

class TodoFailure extends TodoState {
  final String error;

  const TodoFailure(this.error);

 
}
