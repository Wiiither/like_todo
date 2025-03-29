import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/bloc/tag/tag_bloc.dart';
import 'package:like_todo/component/todo/todo_tag_list_content_view.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../base/custom_color.dart';

class TodoTagListPage extends StatefulWidget {
  const TodoTagListPage({super.key});

  @override
  State<TodoTagListPage> createState() => _TodoTagListPageState();
}

class _TodoTagListPageState extends State<TodoTagListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: TodoTagEntityType.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(builder: (context, state) {
      return Column(
        children: [
          TDTabBar(
            controller: _tabController,
            isScrollable: true,
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
            tabs: TodoTagEntityType.values
                .map((item) => _buildTab(text: item.name()))
                .toList(),
          ).padding(horizontal: 20),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: TodoTagEntityType.values
                  .map(
                    (item) => TodoTagListContentView(
                      type: item,
                    ),
                  )
                  .toList(),
            ),
          )
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
