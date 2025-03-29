import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class TodoNavRightMenuView extends StatefulWidget {
  const TodoNavRightMenuView({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<TodoNavRightMenuView> createState() => _TodoNavRightMenuViewState();
}

class _TodoNavRightMenuViewState extends State<TodoNavRightMenuView> {
  @override
  Widget build(BuildContext context) {
    return TDTabBar(
      controller: widget.tabController,
      showIndicator: true,
      dividerHeight: 0.0,
      labelColor: CustomColor.mainColor,
      indicatorColor: CustomColor.mainColor,
      tabs: const [
        TDTab(text: '分组'),
        TDTab(text: '标签'),
      ],
    );
  }
}
