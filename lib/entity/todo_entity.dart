import 'package:like_todo/entity/todo_repeat_type.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';

enum TodoEntityType { main, sub }

const String newToDoID = "new";

class TodoEntity {
  TodoEntity({
    required this.id,
    this.title = "",
    this.mark = "",
    this.isCompleted = false,
    this.type = TodoEntityType.main,
    this.date,
    this.startTime,
    this.endTime,
    required this.repeatType,
    this.tags = const [],
  });

  String id;

  //  标题
  String title;

  //  备注
  String mark;

  //  是否完成
  bool isCompleted;

  //  类型
  TodoEntityType type;

  //  日期
  DateTime? date;

  //  开始时间
  DateTime? startTime;

  //  结束时间
  DateTime? endTime;

  //  类型重复
  TodoRepeatType repeatType;

  //  标签
  List<TodoTagEntity> tags;
}
