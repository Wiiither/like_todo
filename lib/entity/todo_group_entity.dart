import 'package:like_todo/component/todo/create_todo_select_view.dart';

class TodoGroupEntity extends CreateTodoSelectViewDataSource {
  TodoGroupEntity({
    required this.groupID,
    required this.groupName,
    this.isDefault = false,
  });

  final String groupID;
  final String groupName;
  final bool isDefault;

  TodoGroupEntity copyWith({
    String? groupID,
    String? groupName,
    bool? isDefault,
  }) {
    return TodoGroupEntity(
      groupID: groupID ?? this.groupID,
      groupName: groupName ?? this.groupName,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  String getDisplayName() => groupName;
}
