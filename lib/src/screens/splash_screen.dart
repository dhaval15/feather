import '../provider.dart';
import '../views/views.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with ScreenUtilStateMixin {
  @override
  void initState() {
    super.initState();
    checkForCredentials();
  }

  void checkForCredentials() async {
    await Future.delayed(Duration(seconds: 3));
    final user = await Provider.getCurrentUser();
    if (user != null)
      Navigator.of(context).pushReplacementNamed('/home');
    else {
      String emailId = Provider.of(context).fetchEmailId();
      if (emailId != null)
        Navigator.of(context).pushReplacementNamed('/verification');
      else
        Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppLogo(),
              vGap(20),
              AppTitle(),
            ],
          ),
        ),
      ),
    );
  }
}
