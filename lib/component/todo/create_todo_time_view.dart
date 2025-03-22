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
    this.buttonTitle,
    this.isPrefButtonSelected,
    this.buttonAction,
    this.buttonLongAction,
  });

  final String title;
  final String content;
  final bool clearState;
  final Function(DateTime)? onSelectedDateTime;
  final VoidCallback? onClearDateTime;

  final String? buttonTitle;
  final bool? isPrefButtonSelected; //  按钮是否默认被选择
  final VoidCallback? buttonAction;
  final VoidCallback? buttonLongAction;

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
        margin: const EdgeInsets.symmetric(horizontal: 15),
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
            ).padding(right: 10, left: 10),
            Visibility(
              child: Stack(
                children: [
                  TDButton(
                    onTap: buttonAction,
                    onLongPress: buttonLongAction,
                    size: TDButtonSize.extraSmall,
                    height: 24,
                    style: TDButtonStyle(
                      backgroundColor: (isPrefButtonSelected ?? false)
                          ? CustomColor.mainColor
                          : Colors.grey.shade200,
                      textColor: (isPrefButtonSelected ?? false)
                          ? Colors.white
                          : CustomColor.mainColor,
                    ),
                    text: buttonTitle ?? '',
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )
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
