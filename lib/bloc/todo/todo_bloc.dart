import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:like_todo/utils/database_helper.dart';

import '../../entity/todo_entity.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState(todoList: [], lastChangeTime: 0)) {
    on<AddNewToDoEvent>(_addNewTodo);
    on<AddNewToDoArrayEvent>(_addTodoArray);
    on<ChangeToDoCompleted>(_changeTodoCompleted);
    on<LoadToDoFromDatabaseEvent>(_loadDataFromDatabase);
    on<UpdateToDoEvent>(_updateTodoEntity);
    on<DeleteToDoEvent>(_deleteTodoEntity);
  }

  void _addNewTodo(AddNewToDoEvent event, Emitter<TodoState> emit) {
    List<TodoEntity> todoList = List.from(state.todoList);
    todoList.add(event.todoEntity);
    emit(state.copyWith(todoList: todoList));
  }

  void _addTodoArray(AddNewToDoArrayEvent event, Emitter<TodoState> emit) {
    List<TodoEntity> todoList = List.from(state.todoList);
    todoList.addAll(event.todoEntityArray);
    emit(state.copyWith(todoList: todoList));
  }

  void _changeTodoCompleted(
      ChangeToDoCompleted event, Emitter<TodoState> emit) {
    final todoList = state.todoList;
    for (TodoEntity item in todoList) {
      if (item.id == event.id) {
        item.isCompleted = event.isCompleted;
        print("更新 ToDo id ${item.id}");
      }
    }
    emit(state.copyWith(
      todoList: todoList,
      lastChangeTime: DateTime.now().millisecondsSinceEpoch,
    ));
  }

  void _loadDataFromDatabase(
      LoadToDoFromDatabaseEvent event, Emitter<TodoState> emit) async {
    final todoList = await DatabaseHelper().getTodoEntities();
    print("从数据获取的 $todoList");
    emit(state.copyWith(todoList: todoList));
  }

  void _updateTodoEntity(UpdateToDoEvent event, Emitter<TodoState> emit) async {
    List<TodoEntity> todoList = state.todoList;
    int index = 0;
    for (TodoEntity item in todoList) {
      if (item.id == event.todoEntity.id) {
        todoList[index] = event.todoEntity;
        break;
      }
      index++;
    }
    emit(state.copyWith(
      todoList: todoList,
      lastChangeTime: DateTime.now().millisecondsSinceEpoch,
    ));
  }

  void _deleteTodoEntity(DeleteToDoEvent event, Emitter<TodoState> emit) async {
    List<TodoEntity> todoList = List.from(state.todoList);
    todoList.removeWhere((item) => item.id == event.id);
    emit(state.copyWith(todoList: todoList));
  }
}
