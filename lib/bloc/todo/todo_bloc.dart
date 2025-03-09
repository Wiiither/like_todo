import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:like_todo/entity/todo_group_entity.dart';
import 'package:like_todo/utils/database_helper.dart';

import '../../entity/todo_entity.dart';
import '../../utils/achieve_manager.dart';

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
    on<AddGroupEvent>(_addGroup);
    on<DeleteGroupEvent>(_deleteGroup);
    on<EditGroupEvent>(_editGroup);
    on<SetDefaultGroupEvent>(_setDefaultGroup);
  }

  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  void _reloadTodoGroup(
      ReloadTodoGroupEvent event, Emitter<TodoState> emit) async {
    List<TodoGroupEntity> todoGroups = await _dataBaseHelper.getTodoGroups();
    emit(state.copyWith(todoGroupList: todoGroups));
  }

  void _reloadAllTodo(ReloadAllTodoEvent event, Emitter<TodoState> emit) async {
    List<TodoEntity> todos = await _dataBaseHelper.getTodos();
    AchieveManager().loadAchievement(todos);
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
    AchieveManager().loadAchievement(todoList);
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
    AchieveManager().loadAchievement(todoList);
    emit(state.copyWith(
      todoList: todoList,
      groupTodoMap: groupTodoMap,
      lastUpdateDatetime: DateTime.now(),
    ));
  }

  void _addGroup(AddGroupEvent event, Emitter<TodoState> emit) async {
    await _dataBaseHelper.insertTodoGroup(event.groupEntity);
    final groupList = state.todoGroupList;
    groupList.add(event.groupEntity);
    final groupTodoMap = state.groupTodoMap;
    groupTodoMap[event.groupEntity.groupID] = [];
    emit(state.copyWith(
      todoGroupList: groupList,
      groupTodoMap: groupTodoMap,
      lastUpdateDatetime: DateTime.now(),
    ));
  }

  void _deleteGroup(DeleteGroupEvent event, Emitter<TodoState> emit) async {
    final isReserveToDo = event.isReserveToDo;
    List<TodoEntity> todoList = state.groupTodoMap[event.groupID] ?? [];
    if (isReserveToDo) {
      //  需要保留ToDo
      String defaultGroupID =
          state.todoGroupList.firstWhere((item) => item.isDefault).groupID;
      for (TodoEntity todo in todoList) {
        await _dataBaseHelper.updateTodoGroupMappingByToDoID(
          todo.id,
          defaultGroupID,
        );
      }
      await _dataBaseHelper.deleteTodoGroup(event.groupID);
      final groupToDoMap = state.groupTodoMap;
      groupToDoMap.remove(event.groupID);
      final groupList = state.todoGroupList;
      groupList.removeWhere((item) => item.groupID == event.groupID);
      emit(state.copyWith(
        groupTodoMap: groupToDoMap,
        todoGroupList: groupList,
        lastUpdateDatetime: DateTime.now(),
      ));
    } else {
      await _dataBaseHelper.deleteTodoGroupMappingByGroup(event.groupID);
      final allTodoList = state.todoList;
      for (TodoEntity todo in todoList) {
        await _dataBaseHelper.deleteTodo(todo.id);
        allTodoList.removeWhere((item) => item.id == todo.id);
      }
      await _dataBaseHelper.deleteTodoGroup(event.groupID);
      final groupToDoMap = state.groupTodoMap;
      groupToDoMap.remove(event.groupID);
      final groupList = state.todoGroupList;
      groupList.removeWhere((item) => item.groupID == event.groupID);
      emit(state.copyWith(
        todoList: allTodoList,
        groupTodoMap: groupToDoMap,
        todoGroupList: groupList,
        lastUpdateDatetime: DateTime.now(),
      ));
    }
  }

  void _editGroup(EditGroupEvent event, Emitter<TodoState> emit) async {
    await _dataBaseHelper.updateTodoGroup(event.todoGroupEntity);
    int index = 0;
    for (final entity in state.todoGroupList) {
      if (entity.groupID == event.todoGroupEntity.groupID) {
        break;
      }
      index++;
    }
    List<TodoGroupEntity> groupList = List.from(state.todoGroupList);

    if (index <= groupList.length) {
      groupList[index] = event.todoGroupEntity;
    }
    emit(state.copyWith(
      todoGroupList: groupList,
      lastUpdateDatetime: DateTime.now(),
    ));
  }

  void _setDefaultGroup(
      SetDefaultGroupEvent event, Emitter<TodoState> emit) async {
    List<TodoGroupEntity> groupList = List.from(state.todoGroupList);
    for (TodoGroupEntity item in groupList) {
      if (item.isDefault) {
        item.isDefault = false;
        await _dataBaseHelper.updateTodoGroup(item);
      }
      if (item.groupID == event.groupID) {
        item.isDefault = true;
        await _dataBaseHelper.updateTodoGroup(item);
      }
    }
    emit(state.copyWith(
        todoGroupList: groupList, lastUpdateDatetime: DateTime.now()));
  }
}
