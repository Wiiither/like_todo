import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/utils/database_helper.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../bloc/todo/todo_bloc.dart';
import '../../page/todo/create_todo_page.dart';

class TodoItemView extends StatelessWidget {
  const TodoItemView(
      {super.key, required this.todoEntity, required this.context});

  final TodoEntity todoEntity;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeTodoState,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: TDSwipeCell(
          cell: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todoEntity.title,
                      style: const TextStyle(
                        color: CustomColor.mainColor,
                        fontSize: 20,
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
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Text(
                      _startTimeString(todoEntity.startTime!),
                      style: const TextStyle(
                        color: CustomColor.mainColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  todoEntity.isCompleted
                      ? TDIcons.check_circle_filled
                      : TDIcons.circle,
                  color: CustomColor.mainColor,
                )
              ],
            ),
          ),
          right: TDSwipeCellPanel(
            extentRatio: 0.6,
            children: [
              const TDSwipeCellAction(
                backgroundColor: Colors.indigo,
                label: "详情",
              ),
              TDSwipeCellAction(
                backgroundColor: Colors.blueAccent,
                label: "编辑",
                onPressed: (context) {
                  _handleEditTodo(todoEntity);
                },
              ),
              TDSwipeCellAction(
                backgroundColor: Colors.redAccent,
                label: "删除",
                autoClose: false,
                onPressed: (context) {
                  _showDeleteCheckDialog(todoEntity.id);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String _startTimeString(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute}";
  }

  void _changeTodoState() {
    print("点击ToDo");
    final bloc = BlocProvider.of<TodoBloc>(context);
    bloc.add(ChangeToDoCompleted(
        id: todoEntity.id, isCompleted: !todoEntity.isCompleted));
  }

  void _showDeleteCheckDialog(String todoId) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return TDAlertDialog(
          content: '你确认要删除这个ToDo吗？',
          rightBtnAction: () {
            _handleDeleteTodo(todoId);
          },
        );
      },
    );
  }

  void _handleEditTodo(TodoEntity todoEntity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTodoPage(
          todoEntity: todoEntity,
          context: this.context,
        ),
      ),
    );
  }

  void _handleDeleteTodo(String todoId) {
    DatabaseHelper().deleteTodoEntity(todoId);
    final bloc = BlocProvider.of<TodoBloc>(context);
    bloc.add(DeleteToDoEvent(id: todoId));
  }
}
