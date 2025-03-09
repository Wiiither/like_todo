import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/entity/todo_group_entity.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class DeleteGroupCheckView extends StatefulWidget {
  const DeleteGroupCheckView({
    super.key,
    required this.todoGroupEntity,
  });

  final TodoGroupEntity todoGroupEntity;

  @override
  State<DeleteGroupCheckView> createState() => _DeleteGroupCheckViewState();
}

class _DeleteGroupCheckViewState extends State<DeleteGroupCheckView> {
  bool _isReserveTodo = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '分组删除确认',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: CustomColor.mainColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ).padding(bottom: 20),
          TDCheckbox(
            checked: _isReserveTodo,
            title: '分组下ToDo移动到默认分组',
            titleColor: CustomColor.mainColor,
            showDivider: false,
            onCheckBoxChanged: (check) {
              setState(() {
                _isReserveTodo = true;
              });
            },
          ),
          TDCheckbox(
            checked: !_isReserveTodo,
            title: '分组下ToDo同步删除',
            titleColor: CustomColor.mainColor,
            showDivider: false,
            onCheckBoxChanged: (check) {
              setState(() {
                _isReserveTodo = false;
              });
            },
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TDButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: '取消',
                  style: TDButtonStyle(
                    frameColor: CustomColor.mainColor,
                    frameWidth: 1,
                    textColor: CustomColor.mainColor,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TDButton(
                  onTap: () {
                    _handleDeleteGroup(context);
                    Navigator.pop(context);
                  },
                  text: '确认',
                  style: TDButtonStyle(
                    backgroundColor: CustomColor.mainColor,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _handleDeleteGroup(BuildContext context) {
    final bloc = context.read<TodoBloc>();
    bloc.add(DeleteGroupEvent(
      groupID: widget.todoGroupEntity.groupID,
      isReserveToDo: _isReserveTodo,
    ));
  }
}
