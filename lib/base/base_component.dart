import 'package:flutter/cupertino.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'custom_color.dart';

TDNavBar buildBaseNavBar({
  required BuildContext context,
  required String title,
  VoidCallback? onBack,
  List<TDNavBarItem>? rightBarItems,
}) {
  return TDNavBar(
    title: title,
    titleColor: CustomColor.mainColor,
    titleFontWeight: FontWeight.w600,
    titleFont: Font(size: 17, lineHeight: 18),
    useDefaultBack: false,
    leftBarItems: [
      TDNavBarItem(
          icon: TDIcons.chevron_left,
          iconSize: 26,
          iconColor: CustomColor.mainColor,
          action: () {
            onBack?.call();
            Navigator.maybePop(context);
          })
    ],
    rightBarItems: rightBarItems,
  );
}
