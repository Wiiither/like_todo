import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class MeItemView extends StatelessWidget {
  const MeItemView({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: CustomColor.mainColor,
                fontSize: 17,
              ),
            ),
            const Spacer(),
            const Icon(
              TDIcons.chevron_right,
              color: CustomColor.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
