enum AchievementType {
  taskComplete, // 完成任务相关
  taskStreak, // 连续完成相关
  timeManagement, // 时间管理相关
  special, // 特殊成就
  hidden, // 隐藏成就
}

extension AchievementTypeExtension on AchievementType {
  String title() {
    switch (this) {
      case AchievementType.taskComplete:
        return "任务完成";
      case AchievementType.taskStreak:
        return "连续完成";
      case AchievementType.timeManagement:
        return "时间管理";
      case AchievementType.special:
        return "特殊";
      case AchievementType.hidden:
        return "隐藏";
    }
  }
}

class AchievementCheckResult {
  final int nowProgress;
  final DateTime? achieveTime;

  const AchievementCheckResult({
    required this.nowProgress,
    this.achieveTime = null,
  });
}

class AchievementEntity {
  final String id;
  final String title;
  final String description;
  final String achieveProverb;
  final AchievementType type;
  final int nowProgress;
  final int maxProgress;
  final String icon;
  final DateTime? achieveTime;

  AchievementEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.achieveProverb,
      required this.type,
      required this.nowProgress,
      required this.maxProgress,
      required this.icon,
      this.achieveTime});
}
