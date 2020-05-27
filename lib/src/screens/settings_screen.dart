import 'package:flutter/material.dart';
import '../utils/utils.dart';

class SettingScreen extends StatelessWidget with ScreenUtilMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
    );
  }
}
