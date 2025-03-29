import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/bloc/tag/tag_bloc.dart';
import 'package:like_todo/component/tag/add_new_tag_view.dart';
import 'package:like_todo/component/todo/todo_tag_item_view.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class TagManagerItemView extends StatelessWidget {
  const TagManagerItemView({
    super.key,
    required this.type,
    required this.todoTagList,
  });

  final TodoTagEntityType type;
  final List<TodoTagEntity> todoTagList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            type.name(),
            style: const TextStyle(
              color: CustomColor.mainColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...todoTagList.map(
              (entity) {
                return TodoTagItemView(
                  entity: entity,
                  isSelected: false,
                  canClose: !defaultTodoTags.contains(entity),
                );
              },
            ),
            TodoTagAddItemView(
              onTap: () {
                _showAddTagView(context);
              },
            )
          ],
        ).padding(horizontal: 20, bottom: 20),
      ],
    );
  }

  void _showAddTagView(BuildContext context) {
    Navigator.of(context).push(
      TDSlidePopupRoute(
        modalBarrierColor: TDTheme.of(context).fontGyColor2,
        slideTransitionFrom: SlideTransitionFrom.center,
        builder: (buildContext) => BlocProvider.value(
          value: context.read<TagBloc>(),
          child: AddNewTagView(type: type),
        ),
      ),
    );
  }
}
