import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/no_state_view.dart';
import 'package:like_todo/base/time_utils.dart';
import 'package:like_todo/component/todo/todo_item_view.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/entity/todo_group_entity.dart';

import '../../bloc/todo/todo_bloc.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({
    super.key,
    required this.groupEntity,
  });

  final TodoGroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoBloc>();

    List<TodoEntity> todoList = bloc.state.groupTodoMap[groupEntity.groupID]
            ?.where(
                (item) => (item.startTime == null || item.startTime!.isToday()))
            .toList() ??
        [];

    bool isAllComplete = !todoList
        .any((item) => item.isCompleted == false || item.completeTime == null);

    if (!isAllComplete) {
      todoList.sort((a, b) {
        if (a.isCompleted != b.isCompleted) {
          return a.isCompleted ? 1 : -1;
        } else if (a.startTime == null && b.startTime == null) {
          return 0;
        } else if (a.startTime != null && b.startTime != null) {
          return a.startTime!.compareTo(b.startTime!);
        } else {
          return a.startTime == null ? 1 : -1;
        }
      });
    }

    return todoList.isEmpty
        ? const NoStateView(
            type: NoStateType.addSchedule,
            title: '今天还没有添加 ToDo 哦',
          )
        : isAllComplete
            ? const NoStateView(
                type: NoStateType.allComplete,
                title: '你完成今天所有的 ToDo 啦，好好休息吧',
              )
            : ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return TodoItemView(todoEntity: todoList[index]);
                },
              );
  }
}
