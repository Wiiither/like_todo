import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/component/calendar/calendar_sliver_persistent_header_view.dart';
import 'package:like_todo/component/calendar/timeline_item_view.dart';
import 'package:like_todo/entity/timeline_item_entity.dart';
import 'package:like_todo/entity/timeline_item_style.dart';
import 'package:like_todo/entity/todo_entity.dart';

import '../../base/sliver_appbar_delegate.dart';

class CalendarDayContentPage extends StatelessWidget {
  const CalendarDayContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      List<DateTime> sections = _uniqueOrderDateTimeList(
        todoList: state.todoList,
      );
      Map<DateTime, List<TodoEntity>> items = _mapDateTimeTodo(
        dateTimeList: sections,
        todoList: state.todoList,
      );

      return CustomScrollView(
        slivers: <Widget>[
          for (DateTime section in sections) ...[
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                minHeight: 48,
                maxHeight: 48,
                child: CalendarSliverPersistentHeaderView(
                  title: _headerTitle(section),
                  subTitle: _headerSubTitle(section),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return TimelineItemView(
                    entity: _todoEntityConvertToTimelineItem(
                  items[section]![index],
                ));
              }, childCount: items[section]!.length),
            )
          ]
        ],
      );
    });
  }

  List<DateTime> _uniqueOrderDateTimeList(
      {required List<TodoEntity> todoList}) {
    Set<DateTime> dateTimeSet = {};
    for (TodoEntity todo in todoList) {
      if (todo.startTime != null) {
        DateTime dateTime = DateTime(
          todo.startTime!.year,
          todo.startTime!.month,
          todo.startTime!.day,
        );
        dateTimeSet.add(dateTime);
      }
    }

    List<DateTime> dateTimeList = List.from(dateTimeSet);
    dateTimeList.sort((a, b) {
      if (a.isBefore(b)) {
        return -1;
      } else if (a.isAfter(b)) {
        return 1;
      } else {
        return 0;
      }
    });
    return dateTimeList;
  }

  Map<DateTime, List<TodoEntity>> _mapDateTimeTodo(
      {required List<DateTime> dateTimeList,
      required List<TodoEntity> todoList}) {
    Map<DateTime, List<TodoEntity>> result = {};
    for (DateTime dateTime in dateTimeList) {
      List<TodoEntity> todoListForDateTime = todoList.where((todo) {
        if (todo.startTime != null) {
          DateTime startTime = todo.startTime!;
          return startTime.year == dateTime.year &&
              startTime.month == dateTime.month &&
              startTime.day == dateTime.day;
        }
        return false;
      }).toList();
      result[dateTime] = todoListForDateTime;
    }
    return result;
  }

  String _headerTitle(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    int difference = dateTime.difference(today).inDays;
    if (difference < 0) {
      return "${difference.abs()} 天前";
    } else if (difference == 0) {
      return "今天";
    } else if (difference == 1) {
      return "明天";
    } else if (difference == 2) {
      return "后天";
    } else {
      return "${difference} 天后";
    }
  }

  String _headerSubTitle(DateTime dateTime) {
    return "${dateTime.year}/${dateTime.month}/${dateTime.day}";
  }

  TimelineItemEntity _todoEntityConvertToTimelineItem(TodoEntity todoEntity) {
    String title = "";
    if (todoEntity.startTime != null) {
      DateTime startTime = todoEntity.startTime!;
      title +=
          "${"${startTime.hour}".padLeft(2, "0")}:${"${startTime.minute}".padLeft(2, "0")}";
    }
    if (todoEntity.endTime != null) {
      DateTime startTime = todoEntity.startTime!;
      title +=
          "\n至\n${"${startTime.hour}".padLeft(2, "0")}:${"${startTime.minute}".padLeft(2, "0")}";
    }
    return TimelineItemEntity(
      title: title,
      style: TimelineItemTitleStyle.time,
      todoEntity: todoEntity,
    );
  }
}
