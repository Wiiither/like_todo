import 'package:flutter/material.dart';
import 'package:like_todo/component/todo/todo_tag_item_view.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../base/custom_color.dart';

class CreateTodoTagView extends StatelessWidget {
  const CreateTodoTagView({
    super.key,
    required this.selectedTags,
    this.onTap,
  });

  final List<TodoTagEntity> selectedTags;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '标签：',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: CustomColor.mainColor,
              ),
            ).padding(bottom: 6),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: selectedTags
                  .map(
                    (TodoTagEntity entity) => TodoTagItemView(
                      entity: entity,
                      isSelected: false,
                      canClose: false,
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
