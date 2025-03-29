import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/component/todo/todo_tag_item_view.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/page/todo/todo_detail_page.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../bloc/todo/todo_bloc.dart';
import '../../page/todo/create_todo_page.dart';

class TodoItemView extends StatelessWidget {
  const TodoItemView({super.key, required this.todoEntity});

  final TodoEntity todoEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTodoDetail(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: CustomColor.backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            width: 1.0,
            color: CustomColor.quaternaryColor,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  标题
                  Text(
                    todoEntity.title,
                    style: TextStyle(
                      color: todoEntity.isCompleted
                          ? CustomColor.mainColor.withOpacity(0.2)
                          : CustomColor.mainColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  //  备注
                  Visibility(
                    visible: todoEntity.mark.isNotEmpty,
                    child: Text(
                      todoEntity.mark,
                      style: TextStyle(
                        color: todoEntity.isCompleted
                            ? CustomColor.invalidColor
                            : CustomColor.secondaryColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: todoEntity.tags.isNotEmpty,
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: todoEntity.tags
                          .map((item) => TodoTagItemView(
                              entity: item, isSelected: true, canClose: false))
                          .toList(),
                    ).padding(top: 8),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: todoEntity.startTime != null,
                    child: Text(
                      _startTimeString(todoEntity.startTime ?? DateTime.now()),
                      style: TextStyle(
                          color: todoEntity.isCompleted
                              ? CustomColor.invalidColor
                              : CustomColor.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ).padding(top: 4),
                  )
                ],
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                _changeTodoState(context);
              },
              child: Icon(
                todoEntity.isCompleted
                    ? TDIcons.check_circle_filled
                    : TDIcons.circle,
                color: CustomColor.mainColor.withOpacity(0.6),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _startTimeString(DateTime dateTime) {
    return "${'${dateTime.hour}'.padLeft(2, '0')}:${'${dateTime.minute}'.padLeft(2, '0')}";
  }

  void _changeTodoState(BuildContext context) {
    final bloc = context.read<TodoBloc>();
    if (todoEntity.completeTime == null && todoEntity.isCompleted == false) {
      //  此时未完成
      todoEntity.isCompleted = true;
      todoEntity.completeTime = DateTime.now();
    } else {
      //  此时已完成
      todoEntity.isCompleted = false;
      todoEntity.completeTime = null;
    }
    bloc.add(UpdateTodoEvent(todoEntity: todoEntity));
  }

  void _showTodoDetail(BuildContext context) {
    Navigator.of(context).push(
      TDSlidePopupRoute(
          slideTransitionFrom: SlideTransitionFrom.center,
          builder: (ctx) {
            return TodoDetailPage(
                todoEntity: todoEntity,
                editCallback: (_) {
                  _handleEditTodo(context, todoEntity);
                },
                deleteCallback: (_) {
                  _showDeleteCheckDialog(context, todoEntity.id);
                });
          }),
    );
  }

  void _showDeleteCheckDialog(BuildContext context, String todoId) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return TDAlertDialog(
          content: '你确认要删除这个ToDo吗？',
          rightBtnAction: () {
            final bloc = context.read<TodoBloc>();
            bloc.add(DeleteTodoEvent(todoID: todoId));
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _handleEditTodo(BuildContext context, TodoEntity todoEntity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (buildContext) => BlocProvider.value(
          value: context.read<TodoBloc>(),
          child: CreateTodoPage(
            todoEntity: todoEntity,
            isEdit: true,
          ),
        ),
      ),
    );
  }
}
