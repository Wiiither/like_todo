import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/constant_value.dart';
import 'package:like_todo/base/time_utils.dart';
import 'package:like_todo/component/todo/todo_item_view.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/entity/todo_group_entity.dart';

import '../../base/svg_util.dart';
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

    return isAllComplete
        ? SvgAssets.loadSvg(all_complete_svg)
        : todoList.isEmpty
            ? SvgAssets.loadSvg(no_todo_svg)
            : ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return TodoItemView(todoEntity: todoList[index]);
                },
              );
  }
}
