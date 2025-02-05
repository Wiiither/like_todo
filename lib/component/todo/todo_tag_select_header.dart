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
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: CustomColor.mainColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        TDButton(
          text: '确定',
          size: TDButtonSize.small,
          style: TDButtonStyle(
            textColor: Colors.white,
            backgroundColor: CustomColor.mainColor,
          ),
          onTap: confirmCallback,
        )
      ],
    ).padding(horizontal: 20, vertical: 20);
  }
}
