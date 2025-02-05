import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

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
        rightBarItems: [
          TDNavBarItem(
            icon: TDIcons.typography,
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          TDNavBarItem(
            icon: TDIcons.calendar,
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
