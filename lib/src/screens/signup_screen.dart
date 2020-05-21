import 'package:feather/src/screens/screens.dart';

import '../provider.dart';

import '../firebase/firebase.dart';

import '../utils/utils.dart';
import '../views/views.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with ScreenUtilStateMixin {
  final _formKey = GlobalKey<FormState>();
  String emailId, password, name;
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
                          if (Validators.name(text)) return null;
                          return 'Name should be atleast 3 letters';
                        },
                        onSaved: (text) => this.name = text,
                        decoration: InputDecoration(
                            labelText: 'Name', hintText: 'Name'),
                      ),
                      vGap(20),
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
                      TextFormField(
                        validator: (text) {
                          if (Validators.password(text)) return null;
                          return 'Password should contains letters and digits and atleast 6 letters long';
                        },
                        onSaved: (text) => this.password = text,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password', hintText: 'Password'),
                      ),
                      vGap(20),
                      TextFormField(
                        validator: (text) {
                          if (text == password) return null;
                          return 'The password should be same as above';
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Confirm Password'),
                      ),
                      vGap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: _forgotPasswordScreen,
                            child: Text(
                              'Forget Password ?',
                              style: TextStyle(
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _loginScreen,
                            child: Text(
                              'Already a user, Login here',
                              style: TextStyle(
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ),
                        ],
                      ),
                      vGap(10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text('SignUp'),
                          onPressed: _signup,
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

  void _signup() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Response<AuthApi> response =
          await OverlayWidget.of(context).show((context) => LoadingContainer(
                task: () =>
                    AuthApi.createUserWithEmailAndPassword(emailId, password),
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

  void _forgotPasswordScreen() {
    //TODO Add ForgotPasswordScreen and navigate to it.
  }

  void _loginScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
