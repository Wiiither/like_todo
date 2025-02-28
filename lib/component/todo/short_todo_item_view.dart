import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class ShortTodoItemView extends StatelessWidget {
  const ShortTodoItemView({super.key, required this.todoEntity});

  final TodoEntity todoEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeTodoState,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
            Icon(
              todoEntity.isCompleted
                  ? TDIcons.check_circle_filled
                  : TDIcons.circle,
              color: CustomColor.mainColor,
              size: 17,
            )
          ],
        ),
      ),
    );
  }

  void _changeTodoState() {
    print("点击ToDo");
    // final bloc = BlocProvider.of<TodoBloc>(context);
  }
}
