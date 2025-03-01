import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgAssets {
  static SvgPicture loadSvg(
    String path, {
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    ui.Color? color,
    ui.ColorFilter? colorFilter,
  }) {
    return SvgPicture.asset(
      path,
      key: key,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorFilter: colorFilter,
    );
  }
}
