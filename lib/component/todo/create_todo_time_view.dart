import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

enum SelectedTimeType { day, hour }

class CreateTodoTimeView extends StatelessWidget {
  const CreateTodoTimeView({
    super.key,
    required this.title,
    required this.content,
    this.dateTime,
    required this.timeType,
    this.onSelectedDateTime,
  });

  final String title;
  final String content;
  final DateTime? dateTime;
  final SelectedTimeType timeType;
  final Function(DateTime)? onSelectedDateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        TDPicker.showDatePicker(
          context,
          title: title,
          onConfirm: (selected) {
            if (onSelectedDateTime != null) {
              print("selected $selected");
              int year = selected["year"] ?? 2025;
              int month = selected["month"] ?? 1;
              int day = selected["day"] ?? 1;
              int hour = selected["hour"] ?? 12;
              int minute = selected["minute"] ?? 0;
              DateTime newDatetime =
                  DateTime(year, month, day + 1, hour, minute);
              onSelectedDateTime!.call(newDatetime);
            }
            Navigator.of(context).pop();
          },
          useYear: timeType == SelectedTimeType.day,
          useMonth: timeType == SelectedTimeType.day,
          useDay: timeType == SelectedTimeType.day,
          useHour: timeType == SelectedTimeType.hour,
          useMinute: timeType == SelectedTimeType.hour,
          pickerHeight: 250,
          dateStart: timeType == SelectedTimeType.day
              ? [
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ]
              : [
                  0,
                  0,
                  0,
                  0,
                  0,
                ],
          dateEnd: timeType == SelectedTimeType.day
              ? [
                  DateTime.now().year + 1,
                  DateTime.now().month,
                  DateTime.now().day,
                ]
              : [
                  0,
                  0,
                  0,
                  23,
                  59,
                ],
          initialDate: timeType == SelectedTimeType.day
              ? [
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ]
              : [
                  0,
                  0,
                  0,
                  DateTime.now().hour,
                  DateTime.now().minute,
                ],
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              content,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const Icon(
              TDIcons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
