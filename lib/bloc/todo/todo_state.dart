part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState({
    required this.todoList,
    required this.todoGroupList,
    required this.groupTodoMap,
    required this.lastUpdateDatetime,
  });

  final List<TodoEntity> todoList;
  final List<TodoGroupEntity> todoGroupList;
  final Map<String, List<TodoEntity>> groupTodoMap;
  final DateTime lastUpdateDatetime;

  @override
  List<Object?> get props =>
      [todoList, todoGroupList, groupTodoMap, lastUpdateDatetime];

  TodoState copyWith({
    List<TodoEntity>? todoList,
    List<TodoGroupEntity>? todoGroupList,
    Map<String, List<TodoEntity>>? groupTodoMap,
    DateTime? lastUpdateDatetime,
  }) {
    return TodoState(
      todoList: todoList ?? this.todoList,
      todoGroupList: todoGroupList ?? this.todoGroupList,
      groupTodoMap: groupTodoMap ?? this.groupTodoMap,
      lastUpdateDatetime: lastUpdateDatetime ?? this.lastUpdateDatetime,
    );
  }
}
