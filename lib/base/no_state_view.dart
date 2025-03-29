import 'package:flutter/cupertino.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/base/svg_util.dart';

import 'constant_value.dart';

enum NoStateType { noTodo, allComplete, addSchedule }

class NoStateView extends StatelessWidget {
  const NoStateView({
    super.key,
    required this.type,
    this.width = 300,
    this.height = 300,
    this.title,
  });

  final NoStateType type;
  final double width;
  final double height;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgAssets.loadSvg(
            _getSvg(type),
            width: width,
            height: height,
          ),
          Visibility(
            visible: title != null,
            child: Text(
              title ?? "",
              style: const TextStyle(
                color: CustomColor.primaryGray,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getSvg(NoStateType type) {
    switch (type) {
      case NoStateType.noTodo:
        return no_todo_svg;
      case NoStateType.allComplete:
        return all_complete_svg;
      case NoStateType.addSchedule:
        return add_schedule_svg;
      default:
        return "";
    }
  }
}
