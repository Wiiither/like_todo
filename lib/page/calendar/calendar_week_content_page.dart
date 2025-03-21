import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/component/calendar/calendar_sliver_persistent_header_view.dart';
import 'package:like_todo/component/calendar/timeline_item_view.dart';
import 'package:like_todo/entity/timeline_item_entity.dart';
import 'package:like_todo/entity/timeline_item_style.dart';
import 'package:like_todo/entity/todo_entity.dart';

import '../../base/sliver_appbar_delegate.dart';

class CalendarWeekContentPage extends StatelessWidget {
  const CalendarWeekContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      //  存放周一
      List<DateTime> sections = _uniqueOrderMondayList(
        todoList: state.todoList,
      );
      Map<DateTime, Map<int, List<TodoEntity>>> items =
          _mapDateTimeTodo(dateTimeList: sections, todoList: state.todoList);

      return CustomScrollView(
        slivers: <Widget>[
          for (DateTime section in sections) ...[
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                minHeight: 36,
                maxHeight: 36,
                child: CalendarSliverPersistentHeaderView(
                  title: _headerTitle(section),
                  subTitle: _headerSubTitle(section),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                Map<int, List<TodoEntity>> sectionItems = items[section] ?? {};
                List<int> keys = sectionItems.keys.toList();
                keys.sort(
                  (a, b) => a < b
                      ? -1
                      : a > b
                          ? 1
                          : 0,
                );

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int key in keys) ...[
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverAppBarDelegate(
                          minHeight: 36,
                          maxHeight: 36,
                          child: CalendarSliverPersistentHeaderView(
                            title: "$key",
                            subTitle: "",
                          ),
                        ),
                      ),
                      SliverList(
                        delegate:
                            SliverChildBuilderDelegate((context, subIndex) {
                          final todos = sectionItems[key] ?? [];
                          return TimelineItemView(
                              entity: _todoEntityConvertToTimelineItem(
                            todos[subIndex],
                          ));
                        }, childCount: items[section]!.length),
                      ),
                    ]
                  ],
                );
              }, childCount: items[section]?.keys.length),
            )
          ]
        ],
      );
    });
  }

  DateTime _dateTimeToMonday(DateTime dateTime) {
    int weakDay = dateTime.weekday;
    DateTime monday = dateTime.subtract(Duration(days: weakDay - 1));
    return monday;
  }

  List<DateTime> _uniqueOrderMondayList({required List<TodoEntity> todoList}) {
    Set<DateTime> dateTimeSet = {};
    for (TodoEntity todo in todoList) {
      if (todo.startTime != null) {
        DateTime monday = _dateTimeToMonday(todo.startTime!);
        dateTimeSet.add(DateTime(monday.year, monday.month, monday.day));
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

  Map<DateTime, Map<int, List<TodoEntity>>> _mapDateTimeTodo(
      {required List<DateTime> dateTimeList,
      required List<TodoEntity> todoList}) {
    Map<DateTime, Map<int, List<TodoEntity>>> result = {};
    for (TodoEntity todoEntity in todoList) {
      if (todoEntity.startTime != null) {
        final monday = _dateTimeToMonday(todoEntity.startTime!);
        Map<int, List<TodoEntity>> dataMap = result[monday] ?? {};
        final weekDay = todoEntity.startTime!.weekday;
        List<TodoEntity> dataList = dataMap[weekDay] ?? [];
        dataList.add(todoEntity);
        dataMap[weekDay] = dataList;
        result[monday] = dataMap;
      }
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
