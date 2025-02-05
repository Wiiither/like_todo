import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class CreateTodoTimeView extends StatelessWidget {
  const CreateTodoTimeView({
    super.key,
    required this.title,
    required this.content,
    this.dateTime,
    this.onSelectedDateTime,
  });

  final String title;
  final String content;
  final DateTime? dateTime;
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
              int year = selected["year"] ?? 2025;
              int month = selected["month"] ?? 1;
              int day = selected["day"] ?? 1;
              int hour = selected["hour"] ?? 12;
              int minute = selected["minute"] ?? 0;
              DateTime newDatetime = DateTime(year, month, day, hour, minute);
              onSelectedDateTime!.call(newDatetime);
            }
            Navigator.of(context).pop();
          },
          useHour: true,
          useMinute: true,
          pickerHeight: 250,
          dateStart: [
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ],
          dateEnd: [
            DateTime.now().year + 1,
            DateTime.now().month,
            DateTime.now().day,
          ],
          initialDate: [
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
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
