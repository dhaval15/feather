import '../firebase/firebase.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import '../provider.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkForCredentials();
  }

  void checkForCredentials() async {
    final response = await AuthApi.get();
    if (!response.isSuccessful)
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    else if (response.result.isEmailVerified) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      AuthApi api = response.result;
      Provider.of(context).state.init(api);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
