part of 'todo_bloc.dart';

class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class AddNewToDoEvent extends TodoEvent {
  const AddNewToDoEvent({required this.todoEntity});

  final TodoEntity todoEntity;

  @override
  List<Object?> get props => [todoEntity];
}

class AddNewToDoArrayEvent extends TodoEvent {
  const AddNewToDoArrayEvent({required this.todoEntityArray});

  final List<TodoEntity> todoEntityArray;

  @override
  List<Object?> get props => [todoEntityArray];
}

class LoadToDoFromDatabaseEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class ChangeToDoCompleted extends TodoEvent {
  const ChangeToDoCompleted({required this.id, required this.isCompleted});

  final String id;
  final bool isCompleted;

  @override
  List<Object?> get props => [id, isCompleted];
}
