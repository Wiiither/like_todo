import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class CollapseItemView extends StatefulWidget {
  const CollapseItemView({
    super.key,
    required this.title,
    required this.body,
    this.fontSize = 17,
  });

  final String title;
  final Widget body;
  final double fontSize;

  @override
  State<CollapseItemView> createState() => _CollapseItemViewState();
}

class _CollapseItemViewState extends State<CollapseItemView> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        const TDDivider(),
        Visibility(visible: _isExpanded, child: widget.body),
      ],
    );
  }

  Widget _buildTitle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: CustomColor.mainColor,
                fontSize: widget.fontSize,
              ),
            ),
            const Spacer(),
            Icon(_isExpanded ? TDIcons.chevron_up : TDIcons.chevron_down)
          ],
        ),
      ),
    );
  }
}
