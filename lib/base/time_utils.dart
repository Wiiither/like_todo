extension DateTimeListExtension on List<DateTime> {
  List<int> getUniqueYears() {
    // 提取年份并去重
    final uniqueYears = map((date) => date.year).toSet();

    // 将年份转换为 List<String> 并排序
    final sortedYears = uniqueYears.toList()..sort((a, b) => b.compareTo(a));

    return sortedYears;
  }

  List<int> getUniqueMonthsOfYear(int year) {
    final uniqueMonths =
        where((date) => date.year == year).map((date) => date.month).toSet();

    // 将月份转换为 List<String> 并排序
    final sortedMonths = uniqueMonths.toList()..sort((a, b) => b.compareTo(a));
    print('$year 的内容有 $sortedMonths');
    return sortedMonths;
  }

  List<int> getUniqueDayOfMonthAndYear(int year, int month) {
    final uniqueMonths =
        where((date) => date.year == year && date.month == month)
            .map((date) => date.day)
            .toSet();

    // 将月份转换为 List<String> 并排序
    final sortedDays = uniqueMonths.toList()..sort((a, b) => b.compareTo(a));
    print('$year 的内容有 $sortedDays');
    return sortedDays;
  }
}

extension DateTimeExtension on DateTime {
  String getMonthName() {
    switch (month) {
      case 1:
        return "一月";
      case 2:
        return "二月";
      case 3:
        return "三月";
      case 4:
        return "四月";
      case 5:
        return "五月";
      case 6:
        return "六月";
      case 7:
        return "七月";
      case 8:
        return "八月";
      case 9:
        return "九月";
      case 10:
        return "十月";
      case 11:
        return "十一月";
      case 12:
        return "十二月";
      default:
        return "";
    }
  }
}
