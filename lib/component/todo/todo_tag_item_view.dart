import 'package:flutter/material.dart';

import '../../base/custom_color.dart';
import '../../entity/todo_tag_entity.dart';

class TodoTagItemView extends StatelessWidget {
  const TodoTagItemView({
    super.key,
    required this.entity,
    required this.isSelected,
    required this.canClose,
    this.onTap,
  });

  final TodoTagEntity entity;
  final bool isSelected;
  final bool canClose;
  final Function(TodoTagEntity)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call(entity);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: entity.type.typeColor(),
            style: BorderStyle.solid,
          ),
        ),
        child: Text(
          "${entity.name}${canClose ? " × " : ""}",
          style: TextStyle(color: entity.type.typeColor(), fontSize: 12),
        ),
      ),
    );
  }
}

//  标签管理添加标签的视图，与标签的样式类似，因此加到这里
class TodoTagAddItemView extends StatelessWidget {
  const TodoTagAddItemView({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: CustomColor.mainColor.withOpacity(0.6),
            style: BorderStyle.solid,
          ),
        ),
        child: Text(
          '+ 新增',
          style: TextStyle(
            color: CustomColor.mainColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
