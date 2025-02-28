part of 'todo_bloc.dart';

class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class ReloadTodoGroupEvent extends TodoEvent {}

class ReloadAllTodoEvent extends TodoEvent {}

class AddNewTodoEvent extends TodoEvent {
  const AddNewTodoEvent({required this.todoEntity, required this.groupEntity});

  final TodoEntity todoEntity;
  final TodoGroupEntity groupEntity;

  @override
  List<Object?> get props => [todoEntity, groupEntity];
}

class GetTodoByGroupEvent extends TodoEvent {
  const GetTodoByGroupEvent({required this.groupID});

  final String groupID;

  @override
  List<Object?> get props => [groupID];
}

class GetAllGroupTodoEvent extends TodoEvent {}

class UpdateTodoEvent extends TodoEvent {
  const UpdateTodoEvent({required this.todoEntity});

  final TodoEntity todoEntity;

  @override
  List<Object?> get props => [todoEntity];
}

class DeleteTodoEvent extends TodoEvent {
  const DeleteTodoEvent({required this.todoID});

  final String todoID;

  @override
  List<Object?> get props => [todoID];
}
