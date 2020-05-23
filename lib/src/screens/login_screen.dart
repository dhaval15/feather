import 'package:feather/src/screens/screens.dart';

import '../provider.dart';

import '../firebase/firebase.dart';

import '../utils/utils.dart';
import '../views/views.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ScreenUtilStateMixin {
  final _formKey = GlobalKey<FormState>();
  String emailId, password;
  @override
  Widget build(BuildContext context) {
    return OverlayWidget(
      child: Scaffold(
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (text) {
                          if (Validators.emailId(text)) return null;
                          return 'Invalid EmailId';
                        },
                        onSaved: (text) => this.emailId = text,
                        decoration: InputDecoration(
                            labelText: 'EmailId', hintText: 'EmailId'),
                      ),
                      vGap(20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text('Login'),
                          onPressed: _login,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Response<AuthApi> response =
          await OverlayWidget.of(context).show((context) => LoadingContainer(
                task: () => AuthApi.sendVerificationLink(emailId),
              ));
      if (response != null && response.isSuccessful) {
        Provider.of(context).state.init(response.result);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        //Todo : Handle Login Error
      }
    }
  }
}
