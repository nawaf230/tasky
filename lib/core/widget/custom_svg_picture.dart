import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    required this.path,
    required this.colorFilter,
    this.height,
    this.width,
  }) : withColorFilter = true;
  const CustomSvgPicture.withoutColor({
    super.key,
    required this.path,
    this.height,
    this.width,
  }) : colorFilter = Colors.transparent,
       withColorFilter = false;

  final String path;
  final Color colorFilter;
  final bool withColorFilter;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: withColorFilter
          ? ColorFilter.mode(colorFilter, BlendMode.srcIn)
          : null,
      height: height,
      width: width,
    );
  }
}
