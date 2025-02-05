import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class CreateTodoSwitchView extends StatelessWidget {
  const CreateTodoSwitchView({
    super.key,
    required this.title,
    this.isActive = false,
    this.onTap,
  });

  final bool isActive;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              isActive ? TDIcons.check_circle_filled : TDIcons.circle,
              size: 17,
            )
          ],
        ),
      ),
    );
  }
}
