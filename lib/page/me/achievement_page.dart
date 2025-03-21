import 'package:flutter/material.dart';
import 'package:like_todo/base/base_component.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/component/me/achievement_content_view.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.achievementLiteColor,
      appBar: buildBaseNavBar(context: context, title: '成就'),
      body: const AchievementContentView(),
    );
  }
}
