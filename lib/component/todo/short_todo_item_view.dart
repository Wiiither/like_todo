import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../bloc/todo/todo_bloc.dart';
import '../../page/todo/create_todo_page.dart';
import '../../page/todo/todo_detail_page.dart';

class ShortTodoItemView extends StatelessWidget {
  const ShortTodoItemView({super.key, required this.todoEntity});

  final TodoEntity todoEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTodoDetail(context);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  todoEntity.title,
                  style: const TextStyle(
                    color: CustomColor.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Visibility(
                  visible: todoEntity.mark.isNotEmpty,
                  child: Text(
                    todoEntity.mark,
                    style: const TextStyle(
                      color: CustomColor.mainColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                _changeTodoState(context);
              },
              child: Icon(
                todoEntity.isCompleted
                    ? TDIcons.check_circle_filled
                    : TDIcons.circle,
                color: CustomColor.mainColor,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
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
}
