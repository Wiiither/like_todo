import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'calendar_day_content_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> tabTitles = ['日', '周', '月'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TDNavBar(
        title: '时间轴',
        titleColor: CustomColor.mainColor,
        titleFont: Font(size: 20, lineHeight: 22),
        titleFontWeight: FontWeight.w600,
        useDefaultBack: false,
      ),
      body: CalendarDayContentPage(),

      // Column(
      //   children: [
      //     TDTabBar(
      //       controller: _tabController,
      //       tabs: tabTitles
      //           .map((title) => TDTab(
      //                 text: title,
      //               ))
      //           .toList(),
      //     ),
      //     Expanded(
      //       child: TDTabBarView(
      //         controller: _tabController,
      //         children: [
      //           CalendarDayContentPage(),
      //           CalendarWeekContentPage(),
      //           CalendarDayContentPage()
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
