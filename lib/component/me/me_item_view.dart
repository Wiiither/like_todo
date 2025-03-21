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
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 1.5)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: CustomColor.mainColor,
                fontSize: 15,
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
