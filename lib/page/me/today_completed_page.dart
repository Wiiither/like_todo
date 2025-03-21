import 'package:flutter/material.dart';
import 'package:like_todo/base/base_component.dart';

class TodayCompletedPage extends StatelessWidget {
  const TodayCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBaseNavBar(
        context: context,
        title: '今日已完成',
      ),
    );
  }
}
