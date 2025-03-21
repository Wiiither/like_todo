import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';

class CalendarSliverPersistentHeaderView extends StatelessWidget {
  const CalendarSliverPersistentHeaderView({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.mainColor,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(fontSize: 17),
            ),
            TextSpan(
              text: "($subTitle)",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
