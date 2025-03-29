import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/entity/achieve_entity.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../base/constant_value.dart';
import '../../base/svg_util.dart';

class AchievementDialogView extends StatefulWidget {
  const AchievementDialogView({
    super.key,
    required this.achievementEntity,
  });

  final AchievementEntity achievementEntity;

  @override
  State<AchievementDialogView> createState() => _AchievementDialogViewState();
}

class _AchievementDialogViewState extends State<AchievementDialogView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _proverbAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.5, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.1, 0.45, curve: Curves.easeOut),
    ));

    _proverbAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 1.0, curve: Curves.easeInOut),
    ));

    // 启动动画
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: CustomColor.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      // width: MediaQuery.of(context).size.width - 100,
      width: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 240,
            height: 220,
            child: SvgAssets.loadSvg(laurel_wreath_svg,
                color: CustomColor.mainColor.withOpacity(0.1)),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '成就达成 🎉',
                style: TextStyle(
                  color: CustomColor.mainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  decoration: TextDecoration.none,
                ),
              ).padding(bottom: 20),
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        widget.achievementEntity.title,
                        style: const TextStyle(
                          color: CustomColor.mainColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          decoration: TextDecoration.none,
                        ),
                      ).padding(bottom: 5),
                      Text(
                        '达成条件：${widget.achievementEntity.description}',
                        style: const TextStyle(
                          color: CustomColor.mainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ).padding(bottom: 20),
              AnimatedBuilder(
                animation: _proverbAnimation,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [
                          CustomColor.mainColor,
                          CustomColor.mainColor.withOpacity(0.0)
                        ],
                        stops: [
                          _proverbAnimation.value,
                          _proverbAnimation.value
                        ],
                      ).createShader(Offset.zero & bounds.size);
                    },
                    child: Text(
                      widget.achievementEntity.achieveProverb,
                      style: TextStyle(
                        color: CustomColor.mainColor.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  );
                },
              ).padding(top: 5),
            ],
          )
        ],
      ),
    );
  }
}
