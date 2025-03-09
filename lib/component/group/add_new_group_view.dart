import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/entity/todo_group_entity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class AddNewGroupView extends StatelessWidget {
  AddNewGroupView({super.key, this.todoGroupEntity}) {
    if (todoGroupEntity != null) {
      _textEditingController.text = todoGroupEntity!.groupName;
    }
  }

  final TodoGroupEntity? todoGroupEntity;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              todoGroupEntity == null ? '新增分组' : '编辑分组',
              style: const TextStyle(
                color: CustomColor.mainColor,
                decoration: TextDecoration.none,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TDInput(
              controller: _textEditingController,
              cursorColor: CustomColor.mainColor,
              inputDecoration: const InputDecoration(
                hintText: '请输入分组名称',
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TDButton(
                onTap: () {
                  final groupName = _textEditingController.text;
                  _handleCreateGroup(context: context, groupName: groupName);
                  Navigator.pop(context);
                },
                size: TDButtonSize.small,
                style: TDButtonStyle(
                  backgroundColor: CustomColor.mainColor,
                  textColor: Colors.white,
                ),
                text: '保存',
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleCreateGroup(
      {required BuildContext context, required String groupName}) {
    if (groupName.isEmpty) {
      TDToast.showText('分组名称不能为空', context: context);
      return;
    }
    final bloc = context.read<TodoBloc>();
    if (todoGroupEntity == null) {
      TodoGroupEntity groupEntity =
          TodoGroupEntity(groupID: _generateGroupID(), groupName: groupName);

      bloc.add(AddGroupEvent(groupEntity: groupEntity));
    } else {
      TodoGroupEntity groupEntity =
          todoGroupEntity!.copyWith(groupName: groupName);
      bloc.add(EditGroupEvent(todoGroupEntity: groupEntity));
    }
  }

  String _generateGroupID() {
    final DateTime now = DateTime.now();
    final String formatted = '${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}'
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}';
    return formatted;
  }
}
