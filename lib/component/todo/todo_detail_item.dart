import 'package:flutter/cupertino.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../base/custom_color.dart';

class TodoDetailItem extends StatelessWidget {
  const TodoDetailItem({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: CustomColor.mainColor,
            decoration: TextDecoration.none,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        body,
      ],
    ).padding(vertical: 4);
  }
}
