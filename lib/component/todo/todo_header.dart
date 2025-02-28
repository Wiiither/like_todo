import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/base/time_utils.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class TodoHeader extends StatelessWidget implements PreferredSizeWidget {
  const TodoHeader({
    super.key,
  });

  final _headerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return TDNavBar(
      useDefaultBack: false,
      height: _headerHeight,
      centerTitle: false,
      titleWidget: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "${DateTime.now().day}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(text: "/${DateTime.now().getMonthName()}")
          ],
          style: const TextStyle(
            color: CustomColor.mainColor,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_headerHeight);
}
