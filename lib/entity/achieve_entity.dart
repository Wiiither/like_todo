enum AchievementType {
  taskComplete, // 完成任务相关
  taskStreak, // 连续完成相关
  timeManagement, // 时间管理相关
  special, // 特殊成就
  hidden, // 隐藏成就
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
