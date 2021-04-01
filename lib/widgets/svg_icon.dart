import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final String iconName;

  const SvgIcon(
    this.iconName, {
    this.color,
    this.width,
    this.height,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$iconName.svg",
      height: height,
      width: width,
    );
  }
}
