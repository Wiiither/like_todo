import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            color: CustomColor.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: CustomColor.shadowColor,
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 1),
              )
            ]),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todoEntity.title,
                  style: const TextStyle(
                    color: CustomColor.mainColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Visibility(
                  visible: todoEntity.mark.isNotEmpty,
                  child: Text(
                    '备注：${todoEntity.mark}',
                    style: TextStyle(
                      color: CustomColor.mainColor.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ).padding(top: 4),
                ),
                Visibility(
                  visible: todoEntity.startTime != null,
                  child: Text(
                    '开始时间：${_startTimeString(todoEntity.startTime ?? DateTime.now())}',
                    style: TextStyle(
                      color: CustomColor.mainColor.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ).padding(top: 4),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: _changeTodoState,
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

  void _changeTodoState() {
    print("点击ToDo");
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
