import 'package:like_todo/entity/todo_tag_entity.dart';

const String newToDoID = "new";

class TodoEntity {
  TodoEntity({
    required this.id,
    this.title = "",
    this.mark = "",
    this.isCompleted = false,
    this.startTime,
    this.endTime,
    this.completeTime,
    this.tags = const [],
  });

  String id;

  //  标题
  String title;

  //  备注
  String mark;

  //  是否完成
  bool isCompleted;

  //  开始时间
  DateTime? startTime;

  //  结束时间
  DateTime? endTime;

  //  完成时间
  DateTime? completeTime;

  //  标签
  List<TodoTagEntity> tags;
}
