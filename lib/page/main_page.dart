import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/bloc/tab_bar/tab_bar_bloc.dart';
import 'package:like_todo/component/main_tab_bar.dart';
import 'package:like_todo/page/todo/todo_page.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'calendar/calendar_page.dart';
import 'me/me_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        print("更新 MainTab Index : ${_tabController.index}");
        final bloc = BlocProvider.of<TabBarBloc>(context);
        bloc.add(SelectTab(tabIndex: _tabController.index));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TDTabBarView(
        controller: _tabController,
        children: [
          TodoPage(
            context: this.context,
          ),
          CalendarPage(
            context: this.context,
          ),
          MePage(
            context: this.context,
          ),
        ],
      ),
      bottomNavigationBar: MainTabBar(
        tabController: _tabController,
      ),
    );
  }
}
