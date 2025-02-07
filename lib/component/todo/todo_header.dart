import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/entity/todo_repeat_type.dart';
import 'package:like_todo/page/todo/create_todo_page.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${DateTime.now().day}",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(text: "/${_getMonthName()}")
            ],
            style: const TextStyle(
              color: CustomColor.mainColor,
              fontSize: 17,
            ),
          ),
        ),
        TDButton(
          iconWidget: const Icon(
            TDIcons.add,
            size: 24,
            color: CustomColor.mainColor,
          ),
          style: TDButtonStyle(backgroundColor: Colors.transparent),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateTodoPage(
                  todoEntity: TodoEntity(
                    id: newToDoID,
                    repeatType: TodoRepeatType.defaultRepeatType[0],
                  ),
                  context: this.context,
                ),
              ),
            );
          },
        )
      ],
    ).padding(horizontal: 20, vertical: 12);
  }

  String _getMonthName() {
    DateTime now = DateTime.now();
    print("${now.month}");
    switch (now.month) {
      case 1:
        return "一月";
      case 2:
        return "二月";
      case 3:
        return "三月";
      case 4:
        return "四月";
      case 5:
        return "五月";
      case 6:
        return "六月";
      case 7:
        return "七月";
      case 8:
        return "八月";
      case 9:
        return "九月";
      case 10:
        return "十月";
      case 11:
        return "十一月";
      case 12:
        return "十二月";
      default:
        return "";
    }
  }
}
