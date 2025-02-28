import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../base/custom_color.dart';
import 'calendar_time_select_view.dart';

class CreateTodoTimeView extends StatelessWidget {
  const CreateTodoTimeView({
    super.key,
    required this.title,
    required this.content,
    this.clearState = false,
    this.onSelectedDateTime,
    this.onClearDateTime,
  });

  final String title;
  final String content;
  final bool clearState;
  final Function(DateTime)? onSelectedDateTime;
  final VoidCallback? onClearDateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCalendarTimeSelectView(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: CustomColor.mainColor,
              ),
            ),
            const Spacer(),
            Text(
              content,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            GestureDetector(
              onTap: () {
                if (clearState) {
                  onClearDateTime?.call();
                } else {
                  _showCalendarTimeSelectView(context);
                }
              },
              child: Icon(
                clearState
                    ? TDIcons.close_circle_filled
                    : TDIcons.chevron_right,
                color: Colors.grey,
                size: clearState ? 17 : 22,
              ),
            ).padding(left: 15),
          ],
        ),
      ),
    );
  }

  void _showCalendarTimeSelectView(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (buildContext) {
          return CalendarTimeSelectView(
            title: '',
            onSelectedDateTime: (dateTime) {
              onSelectedDateTime?.call(dateTime);
            },
          );
        });
  }
}
