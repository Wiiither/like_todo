import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/entity/todo_group_entity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

typedef ManageGroupMenuAction = Function(TodoGroupEntity);

class ManageGroupMenuView extends StatelessWidget {
  const ManageGroupMenuView({
    super.key,
    required this.todoGroupEntity,
    required this.editGroupAction,
    required this.deleteGroupAction,
    required this.setDefaultGroupAction,
  });

  final TodoGroupEntity todoGroupEntity;
  final ManageGroupMenuAction? editGroupAction;
  final ManageGroupMenuAction? deleteGroupAction;
  final ManageGroupMenuAction? setDefaultGroupAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: !todoGroupEntity.isDefault,
            child: _buildMenuItemView(
              context: context,
              title: '设为默认分组',
              action: setDefaultGroupAction,
            ),
          ),
          _buildMenuItemView(
            context: context,
            title: '编辑分组',
            action: editGroupAction,
          ),
          _buildMenuItemView(
            context: context,
            title: '删除分组',
            action: deleteGroupAction,
          ),
          TDDivider(
            height: 2,
            color: CustomColor.mainColor.withOpacity(0.5),
          ),
          _buildMenuItemView(
            context: context,
            title: '取消',
            action: (_) {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemView({
    required BuildContext context,
    required String title,
    required ManageGroupMenuAction? action,
  }) {
    return GestureDetector(
      onTap: () {
        action?.call(todoGroupEntity);
      },
      child: Container(
        height: 52,
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: CustomColor.mainColor,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
