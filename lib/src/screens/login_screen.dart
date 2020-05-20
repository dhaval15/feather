import '../utils/utils.dart';
import '../views/views.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget with ScreenUtilMixin {
  final GlobalKey<FormFieldState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(sw(20)),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppTitle(),
              vGap(32),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'EmailId'),
                  ),
                  vGap(20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
