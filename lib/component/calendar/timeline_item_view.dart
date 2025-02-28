import 'package:flutter/material.dart';
import 'package:like_todo/entity/timeline_item_style.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../entity/timeline_item_entity.dart';
import '../todo/short_todo_item_view.dart';

class TimelineItemView extends StatelessWidget {
  const TimelineItemView({super.key, required this.entity});

  final TimelineItemEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: entity.style.backgroundColor(),
        border: entity.style.border(),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                entity.title,
                style: entity.style.textStyle(),
                textAlign: TextAlign.right,
              ).padding(horizontal: 6, vertical: 6),
            ),
            VerticalDivider(color: Colors.grey.withOpacity(0.3)),
            Expanded(
              flex: 8,
              child: entity.todoEntity != null
                  ? ShortTodoItemView(todoEntity: entity.todoEntity!)
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
