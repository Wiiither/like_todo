import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class MainTabBar extends StatelessWidget {
  final TabController tabController;

  const MainTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TDBottomTabBar(
          useSafeArea: false,
          TDBottomTabBarBasicType.icon,
          selectedBgColor: CustomColor.backgroundColor,
          navigationTabs: [
            TDBottomTabBarTabConfig(
              tabText: 'ToDo List',
              selectedIcon: const Icon(
                TDIcons.check_double,
                color: CustomColor.mainColor,
              ),
              unselectedIcon: const Icon(
                TDIcons.check_double,
                color: CustomColor.primaryGray,
              ),
              onTap: () {
                tabController.animateTo(0);
              },
            ),
            TDBottomTabBarTabConfig(
              tabText: '日历',
              selectedIcon: const Icon(
                TDIcons.calendar,
                color: CustomColor.mainColor,
              ),
              unselectedIcon: const Icon(
                TDIcons.calendar,
                color: CustomColor.primaryGray,
              ),
              onTap: () {
                tabController.animateTo(1);
              },
            ),
            TDBottomTabBarTabConfig(
              tabText: '我',
              selectedIcon: const Icon(
                TDIcons.user_1,
                color: CustomColor.mainColor,
              ),
              unselectedIcon: const Icon(
                TDIcons.user_1,
                color: CustomColor.primaryGray,
              ),
              onTap: () {
                tabController.animateTo(2);
              },
            ),
          ],
        ),
        Container(
          color: Colors.white,
          height: 30,
        ),
      ],
    );
  }
}
