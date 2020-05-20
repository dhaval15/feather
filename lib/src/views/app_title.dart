import 'package:flutter/material.dart';
import '../utils/utils.dart';

class AppTitle extends StatelessWidget with ScreenUtilMixin {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Feather',
      style: Theme.of(context).textTheme.headline1.copyWith(letterSpacing: 2),
    );
  }
}
