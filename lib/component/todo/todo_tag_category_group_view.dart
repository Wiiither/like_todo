import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/component/todo/todo_tag_item_view.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';
import 'package:styled_widget/styled_widget.dart';

class TodoTagCategoryGroupView extends StatelessWidget {
  const TodoTagCategoryGroupView({
    super.key,
    required this.title,
    required this.tags,
    required this.selectedTags,
    this.onSelectedTag,
  });

  final String title;
  final List<TodoTagEntity> tags;
  final List<TodoTagEntity> selectedTags;
  final Function(TodoTagEntity)? onSelectedTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: TextStyle(color: CustomColor.mainColor, fontSize: 15),
          ),
        ),
        tags.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '暂未内容',
                  style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ).alignment(Alignment.center),
              )
            : Wrap(
                spacing: 6,
                runSpacing: 6,
                children: tags
                    .map(
                      (entity) => TodoTagItemView(
                        entity: entity,
                        isSelected: selectedTags.contains(entity),
                        onTap: onSelectedTag,
                      ),
                    )
                    .toList(),
              ).padding(
                horizontal: 20,
                vertical: 12,
              )
      ],
    );
  }
}
