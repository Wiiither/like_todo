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
