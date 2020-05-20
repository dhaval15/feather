import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilWidget extends StatelessWidget {
  final Widget child;

  const ScreenUtilWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return child;
  }
}
