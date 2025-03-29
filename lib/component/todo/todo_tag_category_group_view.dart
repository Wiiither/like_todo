import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/component/todo/todo_tag_item_view.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class TodoTagCategoryGroupView extends StatelessWidget {
  const TodoTagCategoryGroupView({
    super.key,
    required this.title,
    required this.tags,
    required this.selectedTags,
    this.onSelectedTag,
    this.actionTitle,
    this.action,
  });

  final String title;
  final List<TodoTagEntity> tags;
  final List<TodoTagEntity> selectedTags;
  final Function(TodoTagEntity)? onSelectedTag;
  final String? actionTitle;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: CustomColor.mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Visibility(
                  visible: action != null && actionTitle != null,
                  child: TDButton(
                    size: TDButtonSize.extraSmall,
                    style: TDButtonStyle(
                        backgroundColor: Colors.transparent,
                        textColor: CustomColor.primaryGray),
                    onTap: action,
                    text: actionTitle ?? '',
                  ))
            ],
          ),
        ),
        tags.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  '暂未标签',
                  style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ).alignment(Alignment.center),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags
                    .map(
                      (entity) => TodoTagItemView(
                        entity: entity,
                        isSelected: selectedTags.contains(entity),
                        canClose: false,
                        onTap: onSelectedTag,
                      ),
                    )
                    .toList(),
              ).padding(
                horizontal: 20,
                vertical: 16,
              )
      ],
    );
  }
}
