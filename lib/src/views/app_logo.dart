import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/utils.dart';

class AppLogo extends StatelessWidget with ScreenUtilMixin {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/feather.svg',
      height: sh(96),
      width: sw(96),
    );
  }
}
