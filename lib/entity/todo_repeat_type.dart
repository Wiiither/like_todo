import 'package:like_todo/component/todo/create_todo_select_view.dart';

class TodoRepeatType extends CreateTodoSelectViewDataSource {
  final String name;
  final String key;

  TodoRepeatType({required this.name, required this.key});

  @override
  String getDisplayName() {
    return name;
  }

  static List<TodoRepeatType> defaultRepeatType = [
    TodoRepeatType(name: '仅一次', key: 'onlyOne'),
    TodoRepeatType(name: '工作日', key: 'weekday'),
    TodoRepeatType(name: '周末', key: 'weekend'),
    TodoRepeatType(name: '每天', key: 'everyday'),
    TodoRepeatType(name: '每周一', key: 'monday'),
    TodoRepeatType(name: '每周二', key: 'tuesday'),
    TodoRepeatType(name: '每周三', key: 'wednesday'),
    TodoRepeatType(name: '每周四', key: 'thursday'),
    TodoRepeatType(name: '每周五', key: 'friday'),
    TodoRepeatType(name: '每周六', key: 'saturday'),
    TodoRepeatType(name: '每周日', key: 'sunday'),
  ];

  static TodoRepeatType? findDefaultTypeWithKey(String key) {
    for (TodoRepeatType type in defaultRepeatType) {
      if (type.key == key) {
        return type;
      }
    }
    return null;
  }

  static int? findDefaultTypeIndexWithKey(String key) {
    int index = 0;
    for (TodoRepeatType type in defaultRepeatType) {
      if (type.key == key) {
        return index;
      }
      index++;
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoRepeatType &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          key == other.key;

  @override
  int get hashCode => name.hashCode ^ key.hashCode;
}
