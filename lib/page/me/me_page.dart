import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/base/time_utils.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/component/me/me_statistic_item_view.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/page/group/group_manager_page.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../component/me/me_item_view.dart';

class MePage extends StatelessWidget {
  const MePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TDNavBar(
        title: '我的',
        useDefaultBack: false,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        return Column(
          children: [
            _buildStatisticItems(todoList: state.todoList),
            const SizedBox(height: 20),
            MeItemView(
              title: '分组管理',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (buildContext) => BlocProvider.value(
                      value: context.read<TodoBloc>(),
                      child: GroupManagerPage(),
                    ),
                  ),
                );
              },
            )
          ],
        );
      }),
    );
  }

  Widget _buildStatisticItems({required List<TodoEntity> todoList}) {
    return Row(
      children: [
        Expanded(
            child: MeStatisticItemView(
          title: '今日已完成',
          subTitle: '${_completeCount(todoList)}',
          iconData: TDIcons.check,
          color: CustomColor.completeColor,
          shadowColor: CustomColor.completeLiteColor,
        )),
        Expanded(
            child: MeStatisticItemView(
          title: '今日延期',
          subTitle: '${_postponeCount(todoList)}',
          iconData: TDIcons.time,
          color: CustomColor.postponeColor,
          shadowColor: CustomColor.postponeLiteColor,
        )),
        Expanded(
            child: MeStatisticItemView(
          title: '全部',
          subTitle: '${_allCount(todoList)}',
          iconData: TDIcons.circle,
          color: CustomColor.totalColor,
          shadowColor: CustomColor.totalLiteColor,
        )),
        Expanded(
            child: MeStatisticItemView(
          title: '成就',
          subTitle: '99+',
          iconData: TDIcons.star,
          color: CustomColor.achievementColor,
          shadowColor: CustomColor.achievementLiteColor,
        )),
      ],
    ).padding(horizontal: 10);
  }

  //  统计数值
  //  今日已完成
  int _completeCount(List<TodoEntity> todoList) {
    return todoList
        .where((item) => item.completeTime?.isToday() ?? false)
        .toList()
        .length;
  }

  int _postponeCount(List<TodoEntity> todoList) {
    return todoList
        .where((item) => item.endTime?.isBefore(DateTime.now()) ?? false)
        .toList()
        .length;
  }

  int _allCount(List<TodoEntity> todoList) {
    return todoList.length;
  }
}
