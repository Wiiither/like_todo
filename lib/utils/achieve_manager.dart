import 'package:flutter/cupertino.dart';
import 'package:like_todo/base/achievement_key_constant.dart';
import 'package:like_todo/entity/achieve_entity.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchieveManager {
  static final AchieveManager _instance = AchieveManager._internal();

  factory AchieveManager() {
    return _instance;
  }

  BuildContext? buildContext;

  AchieveManager._internal();

  List<TodoEntity> todoList = [];
  List<AchievementEntity> achievements = [];
  SharedPreferences? preferences;

  bool isAnyHiddenAchieved = false;

  void loadContext(BuildContext context) {
    buildContext = context;
  }

  void loadAchievement(List<TodoEntity> todoList) async {
    this.todoList = todoList;

    if (preferences != null) {
      preferences = await SharedPreferences.getInstance();
    }
    achievements = [];
    //  起步
    AchievementCheckResult firstTaskCheckResult = _checkFirstTask();
    AchievementEntity firstTask = AchievementEntity(
      id: achieveFirstTask,
      title: '起步',
      description: '完成第一个ToDo',
      achieveProverb: '这里一切的开始...',
      type: AchievementType.taskComplete,
      nowProgress: firstTaskCheckResult.nowProgress,
      maxProgress: 1,
      icon: 'icon',
      achieveTime: firstTaskCheckResult.achieveTime,
    );
    achievements.add(firstTask);

    //  初级任务达人
    AchievementCheckResult juniorTaskMasterCheckResult = _checkTaskMaster(
        achieveKey: achieveJuniorTaskMaster, totalProgress: 10);
    AchievementEntity juniorTaskMaster = AchievementEntity(
      id: achieveJuniorTaskMaster,
      title: '初级任务达人',
      description: '完成 10 个ToDo',
      achieveProverb: '10个，不过如此',
      type: AchievementType.taskComplete,
      nowProgress: juniorTaskMasterCheckResult.nowProgress,
      maxProgress: 10,
      icon: 'icon',
      achieveTime: juniorTaskMasterCheckResult.achieveTime,
    );
    achievements.add(juniorTaskMaster);

    //  中级任务达人
    AchievementCheckResult intermediateTaskMasterCheckResult = _checkTaskMaster(
        achieveKey: achieveIntermediateTaskMaster, totalProgress: 50);
    AchievementEntity intermediateTaskMaster = AchievementEntity(
        id: achieveIntermediateTaskMaster,
        title: '中级任务达人',
        description: '完成 50 个ToDo',
        achieveProverb: '50个吗？有点东西',
        type: AchievementType.taskComplete,
        nowProgress: intermediateTaskMasterCheckResult.nowProgress,
        maxProgress: 50,
        icon: 'icon',
        achieveTime: intermediateTaskMasterCheckResult.achieveTime);
    achievements.add(intermediateTaskMaster);

    //  高级任务达人
    AchievementCheckResult advancedTaskMasterCheckResult = _checkTaskMaster(
        achieveKey: achieveAdvancedTaskMaster, totalProgress: 100);
    AchievementEntity advancedTaskMaster = AchievementEntity(
      id: achieveAdvancedTaskMaster,
      title: '高级任务达人',
      description: '完成 100 个ToDo',
      achieveProverb: '100个，恐怖如斯😱',
      type: AchievementType.taskComplete,
      nowProgress: advancedTaskMasterCheckResult.nowProgress,
      maxProgress: 100,
      icon: 'icon',
      achieveTime: advancedTaskMasterCheckResult.achieveTime,
    );
    achievements.add(advancedTaskMaster);

    //  三连
    AchievementCheckResult threeDayStreakCheckResult =
        _checkTimeStreak(achieveKey: achieveThreeDayStreak, totalProgress: 3);
    AchievementEntity threeDayStreak = AchievementEntity(
      id: achieveThreeDayStreak,
      title: '三连',
      description: '连续 3 天完成ToDo',
      achieveProverb: '很多人喜欢3这个数字',
      type: AchievementType.taskStreak,
      nowProgress: threeDayStreakCheckResult.nowProgress,
      maxProgress: 3,
      icon: 'icon',
      achieveTime: threeDayStreakCheckResult.achieveTime,
    );
    achievements.add(threeDayStreak);

    //  一周战士
    AchievementCheckResult weakStreakCheckResult =
        _checkTimeStreak(achieveKey: achieveWeakStreak, totalProgress: 7);
    AchievementEntity weakStreak = AchievementEntity(
      id: achieveWeakStreak,
      title: '一周战士',
      description: '连续 7 天完成ToDo',
      achieveProverb: '完美的一周！',
      type: AchievementType.taskStreak,
      nowProgress: weakStreakCheckResult.nowProgress,
      maxProgress: 7,
      icon: 'icon',
      achieveTime: weakStreakCheckResult.achieveTime,
    );
    achievements.add(weakStreak);

    //  塑望月
    AchievementCheckResult monthStreakCheckResult =
        _checkTimeStreak(achieveKey: achieveMonthStreak, totalProgress: 30);
    AchievementEntity monthStreak = AchievementEntity(
      id: achieveMonthStreak,
      title: '塑望月',
      description: '连续 30 天完成ToDo',
      achieveProverb: '月有阴晴圆缺，于你而言却是完整的一个月。',
      type: AchievementType.taskStreak,
      nowProgress: monthStreakCheckResult.nowProgress,
      maxProgress: 30,
      icon: 'icon',
      achieveTime: monthStreakCheckResult.achieveTime,
    );
    achievements.add(monthStreak);

    //  早起鸟
    AchievementCheckResult earlyBirdCheckResult =
        _checkTimeStreak(achieveKey: achieveEarlyBird, totalProgress: 5);
    AchievementEntity earlyBird = AchievementEntity(
      id: achieveEarlyBird,
      title: '早起鸟',
      description: '连续 5 天在上午10点前完成ToDo',
      achieveProverb: '早起的鸟儿有虫吃，早起的虫儿...值得深思',
      type: AchievementType.timeManagement,
      nowProgress: earlyBirdCheckResult.nowProgress,
      maxProgress: 5,
      icon: 'icon',
      achieveTime: earlyBirdCheckResult.achieveTime,
    );
    achievements.add(earlyBird);

    //  夜猫子
    AchievementCheckResult nightOwlCheckResult = _checkNightOwl();
    AchievementEntity nightOwl = AchievementEntity(
      id: achieveNightOwl,
      title: '夜猫子',
      description: '完成 10 个夜间ToDo',
      achieveProverb: '夜晚也不能够懈怠呢...',
      type: AchievementType.timeManagement,
      nowProgress: nightOwlCheckResult.nowProgress,
      maxProgress: 10,
      icon: 'icon',
      achieveTime: nightOwlCheckResult.achieveTime,
    );
    achievements.add(nightOwl);

    //  从不拖延
    AchievementCheckResult neverDelayCheckResult = _checkNeverDelay();
    AchievementEntity neverDelay = AchievementEntity(
        id: achieveNeverDelay,
        title: '从不拖延',
        description: '连续 5 天都按预期完成ToDo',
        achieveProverb: '可凭此成就证明你没有拖延症',
        type: AchievementType.special,
        nowProgress: neverDelayCheckResult.nowProgress,
        maxProgress: 5,
        icon: 'icon',
        achieveTime: neverDelayCheckResult.achieveTime);
    achievements.add(neverDelay);

    //  完美主义
    AchievementCheckResult perfectionistCheckResult = _checkPerfectionist();
    AchievementEntity perfectionist = AchievementEntity(
        id: achievePerfectionist,
        title: '完美主义',
        description: '完成 10 天所有的当天ToDo',
        achieveProverb: '正如你本人一样',
        type: AchievementType.special,
        nowProgress: perfectionistCheckResult.nowProgress,
        maxProgress: 10,
        icon: 'icon',
        achieveTime: perfectionistCheckResult.achieveTime);
    achievements.add(perfectionist);

    //  深夜执行者
    AchievementCheckResult midnightWorkerCheckResult = _checkMidnightWorker();
    AchievementEntity midnightWorker = AchievementEntity(
        id: achieveMidNightWorker,
        title: '深夜执行者',
        description: '在午夜12点完成任务',
        achieveProverb: '你睡得安稳吗 我必须清醒着',
        type: AchievementType.hidden,
        nowProgress: midnightWorkerCheckResult.nowProgress,
        maxProgress: 1,
        icon: 'icon',
        achieveTime: midnightWorkerCheckResult.achieveTime);
    achievements.add(midnightWorker);

    isAnyHiddenAchieved = achievements.any((item) =>
        item.type == AchievementType.hidden && item.achieveTime != null);
  }

  AchievementCheckResult? _getCheckResult(
      {required String achieveKey, required int totalProgress}) {
    String? achieveTimeString = preferences?.getString(achieveKey);
    if (achieveTimeString != null) {
      DateTime? achieveTime = DateTime.tryParse(achieveTimeString);
      if (achieveTime != null) {
        return AchievementCheckResult(
            nowProgress: totalProgress, achieveTime: achieveTime);
      }
    }
    return null;
  }

  AchievementCheckResult _checkFirstTask() {
    AchievementCheckResult? checkResult =
        _getCheckResult(achieveKey: achieveFirstTask, totalProgress: 1);
    if (checkResult != null) {
      return checkResult;
    }
    bool hasComplete =
        todoList.any((item) => item.isCompleted && item.completeTime != null);
    if (hasComplete) {
      DateTime achieveTime = DateTime.now();
      preferences?.setString(achieveFirstTask, achieveTime.toIso8601String());
      return AchievementCheckResult(nowProgress: 1, achieveTime: achieveTime);
    } else {
      return const AchievementCheckResult(nowProgress: 0);
    }
  }

  AchievementCheckResult _checkTaskMaster(
      {required String achieveKey, required int totalProgress}) {
    AchievementCheckResult? checkResult =
        _getCheckResult(achieveKey: achieveKey, totalProgress: totalProgress);
    if (checkResult != null) {
      return checkResult;
    }
    int completeCount = todoList
        .where((item) => item.isCompleted && item.completeTime != null)
        .toList()
        .length;

    if (completeCount >= totalProgress) {
      DateTime achieveTime = DateTime.now();
      preferences?.setString(achieveKey, achieveTime.toIso8601String());
      return AchievementCheckResult(
          nowProgress: totalProgress, achieveTime: achieveTime);
    } else {
      return AchievementCheckResult(nowProgress: completeCount);
    }
  }

  AchievementCheckResult _checkTimeStreak(
      {required String achieveKey,
      required int totalProgress,
      bool isEarlyBird = false}) {
    AchievementCheckResult? checkResult =
        _getCheckResult(achieveKey: achieveKey, totalProgress: totalProgress);
    if (checkResult != null) {
      return checkResult;
    }
    List<TodoEntity> tmpTodoList = List.from(todoList);
    List<DateTime> completeTimes = tmpTodoList
        .where((item) => item.completeTime != null)
        .map((item) => item.completeTime!)
        .toList();

    completeTimes.sort();

    int maxConsecutiveDays = 0;
    int currentStreak = 0;

    if (completeTimes.length > 1) {
      if (!isEarlyBird) {
        maxConsecutiveDays = 1;
        currentStreak = 1;
      }

      for (int i = 1; i < completeTimes.length; i++) {
        if (completeTimes[i].difference(completeTimes[i - 1]).inDays == 1) {
          if (isEarlyBird && completeTimes[i].hour >= 10) {
            //  早起鸟的连续需要在10点前完成
            currentStreak = 0;
          } else {
            currentStreak++;
          }
        } else {
          currentStreak = isEarlyBird ? 0 : 1;
        }

        if (currentStreak > maxConsecutiveDays) {
          maxConsecutiveDays = currentStreak;
        }
      }
    }

    if (maxConsecutiveDays >= totalProgress) {
      DateTime achieveTime = DateTime.now();
      preferences?.setString(achieveKey, achieveTime.toIso8601String());
      return AchievementCheckResult(
          nowProgress: totalProgress, achieveTime: achieveTime);
    } else {
      return AchievementCheckResult(nowProgress: maxConsecutiveDays);
    }
  }

  AchievementCheckResult _checkNightOwl() {
    AchievementCheckResult? checkResult =
        _getCheckResult(achieveKey: achieveNightOwl, totalProgress: 10);
    if (checkResult != null) {
      return checkResult;
    }

    int count = 0;
    for (TodoEntity item in todoList) {
      if (item.completeTime != null &&
          item.completeTime!.hour > 20 &&
          item.completeTime!.hour < 4) {
        //  夜猫子，完成时间在晚上8点到4点前
        count++;
      }
    }
    if (count >= 10) {
      DateTime achieveTime = DateTime.now();
      preferences?.setString(achieveNightOwl, achieveTime.toIso8601String());
      return AchievementCheckResult(nowProgress: 10, achieveTime: achieveTime);
    } else {
      return AchievementCheckResult(nowProgress: count);
    }
  }

  AchievementCheckResult _checkNeverDelay() {
    AchievementCheckResult? checkResult =
        _getCheckResult(achieveKey: achieveNeverDelay, totalProgress: 5);
    if (checkResult != null) {
      return checkResult;
    }
    List<TodoEntity> tmpTodoList = List.from(todoList);
    tmpTodoList = tmpTodoList
        .where((item) => item.completeTime != null && item.endTime != null)
        .toList();
    tmpTodoList.sort((a, b) {
      return a.completeTime!.isBefore(b.completeTime!) ? -1 : 1;
    });

    int maxConsecutiveDays = 0;
    int currentStreak = 0;
    for (TodoEntity item in tmpTodoList) {
      if (item.completeTime!.isBefore(item.endTime!)) {
        currentStreak += 1;
      } else {
        currentStreak = 0;
      }
      if (currentStreak > maxConsecutiveDays) {
        maxConsecutiveDays = currentStreak;
      }
    }

    if (maxConsecutiveDays >= 5) {
      DateTime achieveTime = DateTime.now();
      preferences?.setString(achieveNeverDelay, achieveTime.toIso8601String());
      return AchievementCheckResult(nowProgress: 5, achieveTime: achieveTime);
    } else {
      return AchievementCheckResult(nowProgress: maxConsecutiveDays);
    }
  }

  AchievementCheckResult _checkPerfectionist() {
    AchievementCheckResult? checkResult =
        _getCheckResult(achieveKey: achievePerfectionist, totalProgress: 10);
    if (checkResult != null) {
      return checkResult;
    }

    Map<String, List<TodoEntity>> dateTimeToDoMap = {};

    for (TodoEntity item in todoList) {
      if (item.completeTime == null || item.endTime == null) {
        continue;
      }
      String mapKey =
          '${item.completeTime!.year}/${item.completeTime!.month}/${item.completeTime!.day}';
      List<TodoEntity> todoList = dateTimeToDoMap[mapKey] ?? [];
      todoList.add(item);
      dateTimeToDoMap[mapKey] = todoList;
    }

    int maxConsecutiveDays = 0;
    dateTimeToDoMap.forEach((_, todoList) {
      bool allCheck = true;
      for (TodoEntity item in todoList) {
        if (item.completeTime!.isAfter(item.endTime!)) {
          allCheck = false;
          break;
        }
      }
      if (allCheck) {
        maxConsecutiveDays++;
      }
    });

    if (maxConsecutiveDays >= 10) {
      DateTime achieveTime = DateTime.now();
      preferences?.setString(
          achievePerfectionist, achieveTime.toIso8601String());
      return AchievementCheckResult(nowProgress: 10, achieveTime: achieveTime);
    } else {
      return AchievementCheckResult(nowProgress: maxConsecutiveDays);
    }
  }

  AchievementCheckResult _checkMidnightWorker() {
    AchievementCheckResult? checkResult =
        _getCheckResult(achieveKey: achieveMidNightWorker, totalProgress: 1);
    if (checkResult != null) {
      return checkResult;
    }
    bool hasComplete = todoList.any((item) =>
        item.isCompleted &&
        item.completeTime != null &&
        item.completeTime!.hour < 1);
    if (hasComplete) {
      DateTime achieveTime = DateTime.now();
      preferences?.setString(
          achieveMidNightWorker, achieveTime.toIso8601String());
      return AchievementCheckResult(nowProgress: 1, achieveTime: achieveTime);
    } else {
      return const AchievementCheckResult(nowProgress: 0);
    }
  }
}
