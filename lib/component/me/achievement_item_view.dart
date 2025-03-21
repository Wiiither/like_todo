import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/entity/achieve_entity.dart';

class AchievementItemView extends StatelessWidget {
  const AchievementItemView({
    super.key,
    required this.achievementEntity,
  });

  final AchievementEntity achievementEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CustomColor.achievementColor,
            CustomColor.achievementColor.withOpacity(0.7),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                achievementEntity.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.achievementLiteColor,
                ),
              ),
              const Spacer(),
              _buildRightWidget()
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '完成条件：${achievementEntity.description}',
            style: const TextStyle(
              fontSize: 15,
              color: CustomColor.achievementLiteColor,
            ),
          ),
          Visibility(
            visible: achievementEntity.achieveTime != null,
            child: Text(
              achievementEntity.achieveProverb,
              style: const TextStyle(
                fontSize: 15,
                color: CustomColor.achievementLiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRightWidget() {
    if (achievementEntity.achieveTime != null) {
      return Text(
        '完成时间：${DateFormat('yyyy-MM-dd').format(achievementEntity.achieveTime!)}',
        style: const TextStyle(
          color: CustomColor.achievementLiteColor,
        ),
      );
    } else {
      return Row(
        children: [
          Text(
            '${achievementEntity.nowProgress}/${achievementEntity.maxProgress}',
            style: const TextStyle(
              color: CustomColor.achievementLiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          Stack(
            children: [
              Container(
                width: 100,
                height: 10,
                decoration: BoxDecoration(
                    color: CustomColor.achievementLiteColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5)),
              ),
              Container(
                width: 100 *
                    achievementEntity.nowProgress /
                    achievementEntity.maxProgress,
                height: 10,
                decoration: BoxDecoration(
                  color: CustomColor.achievementLiteColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              )
            ],
          ),
        ],
      );
    }
  }
}
