import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class SettingSwitchView extends StatelessWidget {
  const SettingSwitchView({
    super.key,
    required this.title,
    required this.isOn,
    this.changeCallBack,
  });

  final String title;
  final bool isOn;
  final Function(bool)? changeCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
          const Spacer(),
          TDSwitch(
            isOn: isOn,
            trackOnColor: CustomColor.mainColor,
            size: TDSwitchSize.small,
          )
        ],
      ),
    );
  }
}
