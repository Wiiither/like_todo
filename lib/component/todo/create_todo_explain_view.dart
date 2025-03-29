import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class CreateTodoExplainView extends StatelessWidget {
  const CreateTodoExplainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Stack(
        children: [
          const Column(
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
                "开始时间和结束时间支持设置默认时间：\n\n1. 点击：设置开始时间为当前时间/设置结束时间为今天最后一分钟。\n\n2. 长按：在之后创建 ToDo 时，以默认时间设置。",
                style: TextStyle(
                    color: CustomColor.secondaryColor,
                    decoration: TextDecoration.none,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  TDIcons.close,
                  color: CustomColor.tertiaryColor,
                  size: 20,
                ),
              ))
        ],
      ),
    );
  }
}
