part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState({required this.todoList, required this.lastChangeTime});

  final List<TodoEntity> todoList;
  final int lastChangeTime;

  @override
  List<Object?> get props => [todoList, lastChangeTime];

  TodoState copyWith({List<TodoEntity>? todoList, int? lastChangeTime}) {
    return TodoState(
      todoList: todoList ?? this.todoList,
      lastChangeTime: lastChangeTime ?? this.lastChangeTime,
    );
  }
}
