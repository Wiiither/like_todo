import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/component/me/achievement_content_tabbar_view.dart';
import 'package:like_todo/entity/achieve_entity.dart';
import 'package:like_todo/utils/achieve_manager.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class AchievementContentView extends StatefulWidget {
  const AchievementContentView({super.key});

  @override
  State<AchievementContentView> createState() => _AchievementContentViewState();
}

class _AchievementContentViewState extends State<AchievementContentView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<AchievementType> showAchievementTab = [];

  @override
  void initState() {
    super.initState();
    showAchievementTab = [
      AchievementType.taskComplete,
      AchievementType.taskStreak,
      AchievementType.timeManagement,
      AchievementType.special,
    ];
    if (AchieveManager().isAnyHiddenAchieved) {
      showAchievementTab.add(AchievementType.hidden);
    }

    _tabController =
        TabController(length: showAchievementTab.length + 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TDTabBar(
          controller: _tabController,
          tabs: [
            const TDTab(text: '全部'),
            ...showAchievementTab.map(
              (item) => TDTab(
                text: item.title(),
              ),
            ),
          ],
          labelColor: CustomColor.achievementColor,
          unselectedLabelColor: CustomColor.achievementColor.withOpacity(0.8),
          isScrollable: true,
        ),
        Expanded(
            child: TDTabBarView(controller: _tabController, children: [
          const AchievementContentTabBarView(
            achievementType: null,
          ),
          ...showAchievementTab.map(
              (item) => AchievementContentTabBarView(achievementType: item))
        ]))
      ],
    );
  }
}
