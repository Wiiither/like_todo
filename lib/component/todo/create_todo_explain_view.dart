import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';

class CreateTodoExplainView extends StatelessWidget {
  const CreateTodoExplainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '提示',
            style: TextStyle(
              color: CustomColor.mainColor,
              decoration: TextDecoration.none,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "开始时间和结束时间支持设置默认时间：\n1. 点击：设置开始时间为当前时间/设置结束时间为今天最后一分钟。\n2. 长按：在之后创建 ToDo 时，以默认时间设置。",
            style: TextStyle(
              color: CustomColor.mainColor,
              decoration: TextDecoration.none,
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
