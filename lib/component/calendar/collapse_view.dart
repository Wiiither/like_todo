import 'package:flutter/cupertino.dart';

import 'collapse_item_view.dart';

class CollapseView extends StatelessWidget {
  const CollapseView({super.key, required this.children});

  final List<CollapseItemView> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }
}
