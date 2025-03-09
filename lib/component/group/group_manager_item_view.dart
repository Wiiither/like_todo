import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/component/group/delete_group_check_view.dart';
import 'package:like_todo/component/group/manage_group_menu_view.dart';
import 'package:like_todo/entity/todo_group_entity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../bloc/todo/todo_bloc.dart';
import 'add_new_group_view.dart';

class GroupManagerItemView extends StatelessWidget {
  const GroupManagerItemView({
    super.key,
    required this.todoGroupEntity,
  });

  final TodoGroupEntity todoGroupEntity;

  @override
  Widget build(BuildContext context) {
    bool isDefault = todoGroupEntity.isDefault;
    return GestureDetector(
      onLongPress: () {
        _showMenuView(context, todoGroupEntity);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Text(
              todoGroupEntity.groupName,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: isDefault,
              child: const Icon(
                TDIcons.crooked_smile_filled,
                color: Colors.amberAccent,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showMenuView(
    BuildContext context,
    TodoGroupEntity todoGroupEntity,
  ) {
    Navigator.of(context).push(
      TDSlidePopupRoute(
        modalBarrierColor: TDTheme.of(context).fontGyColor2,
        slideTransitionFrom: SlideTransitionFrom.bottom,
        builder: (buildContext) => BlocProvider.value(
          value: context.read<TodoBloc>(),
          child: ManageGroupMenuView(
            todoGroupEntity: todoGroupEntity,
            editGroupAction: (entity) {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 300), () {
                _handleEditGroup(context: context, todoGroupEntity: entity);
              });
            },
            deleteGroupAction: (entity) {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 300), () {
                _showDeleteCheckView(context: context, todoGroupEntity: entity);
              });
            },
            setDefaultGroupAction: (entity) {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 300), () {
                _handleSetDefaultGroup(
                    context: context, todoGroupEntity: entity);
              });
            },
          ),
        ),
      ),
    );
  }

  void _showDeleteCheckView({
    required BuildContext context,
    required TodoGroupEntity todoGroupEntity,
  }) {
    Navigator.of(context).push(
      TDSlidePopupRoute(
        modalBarrierColor: TDTheme.of(context).fontGyColor2,
        slideTransitionFrom: SlideTransitionFrom.center,
        builder: (buildContext) => BlocProvider.value(
          value: context.read<TodoBloc>(),
          child: DeleteGroupCheckView(
            todoGroupEntity: todoGroupEntity,
          ),
        ),
      ),
    );
  }

  void _handleEditGroup(
      {required BuildContext context,
      required TodoGroupEntity todoGroupEntity}) {
    Navigator.of(context).push(
      TDSlidePopupRoute(
        modalBarrierColor: TDTheme.of(context).fontGyColor2,
        slideTransitionFrom: SlideTransitionFrom.center,
        builder: (buildContext) => BlocProvider.value(
          value: context.read<TodoBloc>(),
          child: AddNewGroupView(
            todoGroupEntity: todoGroupEntity,
          ),
        ),
      ),
    );
  }

  void _handleSetDefaultGroup(
      {required BuildContext context,
      required TodoGroupEntity todoGroupEntity}) {
    final bloc = context.read<TodoBloc>();
    bloc.add(SetDefaultGroupEvent(groupID: todoGroupEntity.groupID));
  }
}
