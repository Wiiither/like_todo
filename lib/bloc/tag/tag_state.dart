part of 'tag_bloc.dart';

class TagState extends Equatable {
  const TagState({
    required this.todoTagList,
    required this.lastUpdateDatetime,
  });

  final List<TodoTagEntity> todoTagList;

  final DateTime lastUpdateDatetime;

  @override
  List<Object?> get props => [todoTagList, lastUpdateDatetime];

  TagState copyWith(
      {List<TodoTagEntity>? todoTagList, DateTime? lastUpdateDatetime}) {
    return TagState(
      todoTagList: todoTagList ?? this.todoTagList,
      lastUpdateDatetime: lastUpdateDatetime ?? this.lastUpdateDatetime,
    );
  }
}
