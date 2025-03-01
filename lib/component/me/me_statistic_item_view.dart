import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';

class MeStatisticItemView extends StatelessWidget {
  const MeStatisticItemView({
    super.key,
    required this.title,
    required this.subTitle,
    required this.iconData,
    required this.color,
    required this.shadowColor,
    this.borderRadius = 8,
  });

  final String title;
  final String subTitle;
  final IconData iconData;
  final Color color;
  final Color shadowColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withOpacity(0.5),
                ],
              ),
              boxShadow: [
                BoxShadow(color: shadowColor, blurRadius: 8, spreadRadius: 4)
              ]),
          height: 108,
          child: Stack(
            children: [
              Positioned(
                top: -16,
                left: -16,
                child: Icon(
                  iconData,
                  color: Colors.white.withOpacity(0.6),
                  size: 64,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Text(
                  subTitle,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: CustomColor.mainColor,
          ),
        ),
      ],
    );
  }
}
