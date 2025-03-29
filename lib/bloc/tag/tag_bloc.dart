import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';

import '../../utils/database_helper.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc()
      : super(TagState(
            todoTagList: const [], lastUpdateDatetime: DateTime.now())) {
    on<LoadDefaultTagEvent>(_loadDefaultTag);
    on<AddNewTagEvent>(_addNewTag);
  }

  final _dataBaseHelper = DataBaseHelper();

  void _loadDefaultTag(
      LoadDefaultTagEvent event, Emitter<TagState> emit) async {
    List<TodoTagEntity> todoTagList = [];
    todoTagList.addAll(defaultTodoTags);
    final tagInDataBase = await _dataBaseHelper.loadAllTags();
    todoTagList.addAll(tagInDataBase);
    emit(state.copyWith(
      todoTagList: todoTagList,
      lastUpdateDatetime: DateTime.now(),
    ));
  }

  void _addNewTag(AddNewTagEvent event, Emitter<TagState> emit) {
    _dataBaseHelper.insertTag(event.todoTag);
    final todoTagList = state.todoTagList;
    todoTagList.add(event.todoTag);
    emit(
      state.copyWith(
        todoTagList: todoTagList,
        lastUpdateDatetime: DateTime.now(),
      ),
    );
  }
}
