import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class TodoTagSelectHeader extends StatelessWidget {
  const TodoTagSelectHeader({
    super.key,
    required this.title,
    this.confirmCallback,
  });

  final String title;
  final VoidCallback? confirmCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: CustomColor.mainColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            TDButton(
              text: '确定',
              size: TDButtonSize.extraSmall,
              textStyle: const TextStyle(fontSize: 12),
              style: TDButtonStyle(
                  textColor: Colors.white,
                  backgroundColor: CustomColor.mainColor),
              onTap: confirmCallback,
            )
          ],
        ),
        const TDDivider(
          margin: EdgeInsets.only(top: 15),
          color: CustomColor.quaternaryColor,
        )
      ],
    ).padding(horizontal: 20, top: 20, bottom: 10);
  }
}
