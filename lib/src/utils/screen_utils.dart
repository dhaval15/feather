import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin ScreenUtilMixin on StatelessWidget {
  num sh(num height) => ScreenUtil().setHeight(height);
  num sw(num width) => ScreenUtil().setWidth(width);
  num sf(num fontSize) => ScreenUtil().setSp(fontSize);
  Size ss(num width, num height) => Size(sw(width), sh(height));
  SizedBox vGap(num height) => SizedBox(height: sh(height));
  SizedBox hGap(num width) => SizedBox(width: sw(width));
}

mixin ScreenUtilStateMixin<T extends StatefulWidget> on State<T> {
  num sh(num height) => ScreenUtil().setHeight(height);
  num sw(num width) => ScreenUtil().setWidth(width);
  num sf(num fontSize) => ScreenUtil().setSp(fontSize);
  Size ss(num width, num height) => Size(sw(width), sh(height));
  SizedBox vGap(num height) => SizedBox(height: sh(height));
  SizedBox hGap(num width) => SizedBox(width: sw(width));
}
