import '../firebase/firebase.dart';
import 'login_screen.dart';
import 'home_screen.dart';
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
    final response = await AuthApi.get();
    if (!response.isSuccessful)
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    else if (response.result.isEmailVerified) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      AuthApi api = response.result;
      Provider.of(context).state.init(api);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
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
