import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../base/custom_color.dart';
import '../../entity/todo_tag_entity.dart';

class TodoTagItemView extends StatelessWidget {
  const TodoTagItemView(
      {super.key, required this.entity, required this.isSelected, this.onTap});

  final TodoTagEntity entity;
  final bool isSelected;
  final Function(TodoTagEntity)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call(entity);
      },
      child: TDTag(
        entity.name,
        style: TDTagStyle(
            border: isSelected ? 1 : 0,
            borderColor: CustomColor.mainColor,
            borderRadius: BorderRadius.circular(4)),
        textColor: Colors.white,
        backgroundColor: entity.type.typeColor(),
      ),
    );
  }
}
