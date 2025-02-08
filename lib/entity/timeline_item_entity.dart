import 'package:like_todo/entity/timeline_item_style.dart';
import 'package:like_todo/entity/todo_entity.dart';

class TimelineItemEntity {
  const TimelineItemEntity({
    required this.title,
    required this.style,
    this.todoEntity,
  });

  final String title;
  final TimelineItemTitleStyle style;
  final TodoEntity? todoEntity;
}
