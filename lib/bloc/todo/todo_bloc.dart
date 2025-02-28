import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:like_todo/entity/todo_group_entity.dart';
import 'package:like_todo/utils/database_helper.dart';

import '../../entity/todo_entity.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc()
      : super(
          TodoState(
            todoList: [],
            todoGroupList: [],
            groupTodoMap: {},
            lastUpdateDatetime: DateTime.now(),
          ),
        ) {
    on<ReloadTodoGroupEvent>(_reloadTodoGroup);
    on<ReloadAllTodoEvent>(_reloadAllTodo);
    on<AddNewTodoEvent>(_addNewTodo);
    on<GetTodoByGroupEvent>(_getTodoByGroup);
    on<GetAllGroupTodoEvent>(_getAllGroupTodo);
    on<UpdateTodoEvent>(_updateTodo);
    on<DeleteTodoEvent>(_deleteTodo);
  }

  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  void _reloadTodoGroup(
      ReloadTodoGroupEvent event, Emitter<TodoState> emit) async {
    List<TodoGroupEntity> todoGroups = await _dataBaseHelper.getTodoGroups();
    emit(state.copyWith(todoGroupList: todoGroups));
  }

  void _reloadAllTodo(ReloadAllTodoEvent event, Emitter<TodoState> emit) async {
    List<TodoEntity> todos = await _dataBaseHelper.getTodos();
    emit(state.copyWith(todoList: todos));
  }

  void _addNewTodo(AddNewTodoEvent event, Emitter<TodoState> emit) async {
    await _dataBaseHelper.insertTodo(event.todoEntity);
    await _dataBaseHelper.insertTodoGroupMapping(
      event.todoEntity.id,
      event.groupEntity.groupID,
    );
    add(GetTodoByGroupEvent(groupID: event.groupEntity.groupID));
    add(ReloadAllTodoEvent());
  }

  void _getTodoByGroup(
      GetTodoByGroupEvent event, Emitter<TodoState> emit) async {
    List<TodoEntity> todos =
        await _dataBaseHelper.getTodosByGroup(event.groupID);
    Map<String, List<TodoEntity>> groupTodoMap = Map.from(state.groupTodoMap);
    groupTodoMap[event.groupID] = todos;
    emit(state.copyWith(groupTodoMap: groupTodoMap));
  }

  void _getAllGroupTodo(
      GetAllGroupTodoEvent event, Emitter<TodoState> emit) async {
    Map<String, List<TodoEntity>> groupTodoMap =
        await _dataBaseHelper.getAllGroupTodos();
    emit(state.copyWith(groupTodoMap: groupTodoMap));
  }

  void _updateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    await _dataBaseHelper.updateTodo(event.todoEntity);
    final todoList = state.todoList;
    todoList.removeWhere((item) => item.id == event.todoEntity.id);
    todoList.add(event.todoEntity);

    final groupTodoMap = state.groupTodoMap;
    Set<String> updateKey = {};
    groupTodoMap.forEach((key, value) {
      for (TodoEntity item in value) {
        if (item.id == event.todoEntity.id) {
          updateKey.add(key);
        }
      }
    });
    for (String key in updateKey) {
      groupTodoMap[key]?.removeWhere((item) => item.id == event.todoEntity.id);
      groupTodoMap[key]?.add(event.todoEntity);
    }
    emit(state.copyWith(
      todoList: todoList,
      groupTodoMap: groupTodoMap,
      lastUpdateDatetime: DateTime.now(),
    ));
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    await _dataBaseHelper.deleteTodo(event.todoID);
    await _dataBaseHelper.deleteTodoGroupMappingByTodo(event.todoID);
    final todoList = state.todoList;
    final groupTodoMap = state.groupTodoMap;
    todoList.removeWhere((item) => item.id == event.todoID);
    Set<String> removeKey = {};
    groupTodoMap.forEach((key, value) {
      for (TodoEntity item in value) {
        if (item.id == event.todoID) {
          removeKey.add(key);
        }
      }
    });
    for (String key in removeKey) {
      groupTodoMap[key]?.removeWhere((item) => item.id == event.todoID);
    }
    emit(state.copyWith(
      todoList: todoList,
      groupTodoMap: groupTodoMap,
      lastUpdateDatetime: DateTime.now(),
    ));
  }
}
