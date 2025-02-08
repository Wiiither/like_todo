import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/time_utils.dart';
import 'package:like_todo/component/calendar/timeline_item_view.dart';
import 'package:like_todo/entity/timeline_item_entity.dart';
import 'package:like_todo/entity/timeline_item_style.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../bloc/todo/todo_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.context});

  final BuildContext context;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TDNavBar(
        title: '时间轴',
        centerTitle: false,
        useDefaultBack: false,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          List<TimelineItemEntity> dataArray =
              _convertToTimelineItem(state.todoList);

          return state.todoList.isEmpty
              ? const TDEmpty(
                  type: TDEmptyType.plain,
                  emptyText: 'DooooooooIt',
                )
              : SingleChildScrollView(
                  child: Column(
                    children: dataArray.map((item) {
                      return TimelineItemView(entity: item);
                    }).toList(),
                  ),
                );
        },
      ),
    );
  }

  List<TimelineItemEntity> _convertToTimelineItem(List<TodoEntity> todoList) {
    List<TimelineItemEntity> result = [];
    List<DateTime> todoDateTimes = todoList.map((entity) {
      return entity.date!;
    }).toList();
    final years = todoDateTimes.getUniqueYears();

    for (int year in years) {
      result.add(
        TimelineItemEntity(
          title: '$year年',
          style: TimelineItemTitleStyle.year,
        ),
      );
      final months = todoDateTimes.getUniqueMonthsOfYear(year);
      for (int month in months) {
        result.add(
          TimelineItemEntity(
            title: '$month月',
            style: TimelineItemTitleStyle.month,
          ),
        );
        final days = todoDateTimes.getUniqueDayOfMonthAndYear(year, month);
        for (int day in days) {
          result.add(
            TimelineItemEntity(
              title: '$day日',
              style: TimelineItemTitleStyle.day,
            ),
          );
          List<TodoEntity> dayTodoList = todoList.where((entity) {
            return entity.date!.year == year &&
                entity.date!.month == month &&
                entity.date!.day == day;
          }).toList();
          for (TodoEntity todoEntity in dayTodoList) {
            result.add(
              TimelineItemEntity(
                  title:
                      '${'${todoEntity.startTime!.hour}'.padLeft(2, '0')}:${'${todoEntity.startTime!.minute}'.padLeft(2, '0')}',
                  style: TimelineItemTitleStyle.time,
                  todoEntity: todoEntity),
            );
          }
        }
      }
    }
    return result;
  }
}
