import 'package:flutter/cupertino.dart';
import 'package:like_todo/component/me/achievement_item_view.dart';
import 'package:like_todo/entity/achieve_entity.dart';
import 'package:like_todo/utils/achieve_manager.dart';

class AchievementContentTabBarView extends StatelessWidget {
  const AchievementContentTabBarView({
    super.key,
    required this.achievementType,
  });

  final AchievementType? achievementType;

  @override
  Widget build(BuildContext context) {
    List<AchievementEntity> achievements = AchieveManager().achievements;
    if (achievementType != null) {
      achievements =
          achievements.where((item) => item.type == achievementType).toList();
    }
    return ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return AchievementItemView(
            achievementEntity: achievements[index],
          );
        });
  }
}
