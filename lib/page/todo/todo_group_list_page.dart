import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/entity/todo_group_entity.dart';
import 'package:like_todo/page/todo/todo_list_page.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class TodoGroupListPage extends StatefulWidget {
  const TodoGroupListPage({super.key});

  @override
  State<TodoGroupListPage> createState() => _TodoGroupListPageState();
}

class _TodoGroupListPageState extends State<TodoGroupListPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      List<TodoGroupEntity> groups = state.todoGroupList;
      _tabController = TabController(length: groups.length, vsync: this);

      return Column(
        children: [
          TDTabBar(
            isScrollable: true,
            controller: _tabController,
            backgroundColor: Colors.white,
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: CustomColor.mainColor,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            tabs: groups.map((group) {
              return _buildTab(text: group.groupName);
            }).toList(),
          ).padding(horizontal: 20),
          Expanded(
            child: TDTabBarView(
              controller: _tabController,
              children: groups.map((group) {
                return TodoListPage(
                  groupEntity: group,
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }

  TDTab _buildTab({required String text}) {
    return TDTab(
      text: text,
      size: TDTabSize.large,
    );
  }
}
