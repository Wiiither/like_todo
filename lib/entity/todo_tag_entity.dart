import 'package:flutter/material.dart';

enum TodoTagEntityType {
  //  类别
  category,
  //  复杂程度
  complexity,
  //  紧急程度
  urgency,
  //  重要程度
  importance,
  //  达成效果
  completion,
  //  自定义
  custom
}

class TodoTagEntity {
  TodoTagEntity({
    required this.name,
    required this.type,
  });

  final String name;
  final TodoTagEntityType type;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TodoTagEntity && other.name == name && other.type == type;
  }

  @override
  int get hashCode => name.hashCode ^ type.hashCode;

  @override
  String toString() {
    return '${typeToString(type)}:$name';
  }

  static TodoTagEntity fromString(String str) {
    final parts = str.split(':');
    return TodoTagEntity(
        name: parts[1], type: stringToTodoTagEntityType(parts[0]));
  }

  // 将 TodoTagEntityType 转换为字符串
  String typeToString(TodoTagEntityType type) {
    return type.toString().split('.').last; // 获取 enum 的名称
  }

// 从字符串转换为 TodoTagEntityType
  static TodoTagEntityType stringToTodoTagEntityType(String typeString) {
    return TodoTagEntityType.values.firstWhere(
      (e) => e.toString().split('.').last == typeString,
      orElse: () =>
          throw ArgumentError('Invalid TodoTagEntityType: $typeString'),
    );
  }
}

List<TodoTagEntity> defaultTodoTags = [
  //  分类
  TodoTagEntity(name: '生活', type: TodoTagEntityType.category),
  TodoTagEntity(name: '工作', type: TodoTagEntityType.category),
  TodoTagEntity(name: '交际', type: TodoTagEntityType.category),
  TodoTagEntity(name: '学习', type: TodoTagEntityType.category),
  //  复杂程度
  TodoTagEntity(name: '简单', type: TodoTagEntityType.complexity),
  TodoTagEntity(name: '中等', type: TodoTagEntityType.complexity),
  TodoTagEntity(name: '复杂', type: TodoTagEntityType.complexity),
  //  紧急程度
  TodoTagEntity(name: '低优先级', type: TodoTagEntityType.urgency),
  TodoTagEntity(name: '中优先级', type: TodoTagEntityType.urgency),
  TodoTagEntity(name: '高优先级', type: TodoTagEntityType.urgency),
  TodoTagEntity(name: '紧急', type: TodoTagEntityType.urgency),
  //  重要程度
  TodoTagEntity(name: '不重要', type: TodoTagEntityType.importance),
  TodoTagEntity(name: '一般', type: TodoTagEntityType.importance),
  TodoTagEntity(name: '重要', type: TodoTagEntityType.importance),
  TodoTagEntity(name: '非常重要', type: TodoTagEntityType.importance),
  //  达到效果
  TodoTagEntity(name: '一般', type: TodoTagEntityType.completion),
  TodoTagEntity(name: '完整', type: TodoTagEntityType.completion),
  TodoTagEntity(name: '完美', type: TodoTagEntityType.completion),
];

extension TodoTagEntityTypeExtension on TodoTagEntityType {
  Color typeColor() {
    switch (this) {
      case TodoTagEntityType.category:
        return const Color(0xff119822);
      case TodoTagEntityType.complexity:
        return const Color(0xffF49D38);
      case TodoTagEntityType.urgency:
        return const Color(0xffD72638);
      case TodoTagEntityType.importance:
        return const Color(0xff78C0E0);
      case TodoTagEntityType.completion:
        return const Color(0xff3943B7);
      case TodoTagEntityType.custom:
        return const Color(0xffDBE4EE);
    }
  }

  String name() {
    switch (this) {
      case TodoTagEntityType.category:
        return "类别";
      case TodoTagEntityType.complexity:
        return "复杂程度";
      case TodoTagEntityType.urgency:
        return "紧急程度";
      case TodoTagEntityType.importance:
        return "重要程度";
      case TodoTagEntityType.completion:
        return "达到效果";
      case TodoTagEntityType.custom:
        return "自定义";
    }
  }
}
