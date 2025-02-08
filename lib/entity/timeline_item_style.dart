import 'package:flutter/material.dart';

import '../base/custom_color.dart';

enum TimelineItemTitleStyle { year, month, day, time }

extension TimelineItemStyleExtension on TimelineItemTitleStyle {
  TextStyle textStyle() {
    switch (this) {
      case TimelineItemTitleStyle.year:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );
      case TimelineItemTitleStyle.month:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );
      case TimelineItemTitleStyle.day:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        );
      case TimelineItemTitleStyle.time:
        return const TextStyle(
          fontSize: 14,
          color: CustomColor.mainColor,
        );
    }
  }

  Color backgroundColor() {
    switch (this) {
      case TimelineItemTitleStyle.year:
      case TimelineItemTitleStyle.month:
      case TimelineItemTitleStyle.day:
        return CustomColor.mainColor.withOpacity(0.8);
      default:
        return Colors.white;
    }
  }

  Border? border() {
    switch (this) {
      case TimelineItemTitleStyle.year:
      case TimelineItemTitleStyle.month:
      case TimelineItemTitleStyle.day:
        return null;
      case TimelineItemTitleStyle.time:
        return Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3)));
    }
  }
}
