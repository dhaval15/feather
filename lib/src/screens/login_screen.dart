import '../platform/feather.dart';
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
  String emailId;

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initDynamicLinks() async {
    Feather.instance.onIntent((data) async {
      print(data);
      final response = await AuthApi.verifyEmailLink(emailId, data);
      print(response.isSuccessful);
    });
  }

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
                      child: Builder(
                        builder: (context) => FlatButton(
                          child: Text('Send Link'),
                          onPressed: () => _login(context),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Builder(
                        builder: (context) => FlatButton(
                          child: Text('Catch'),
                          onPressed: () async {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final result = await showDialog(
          context: context,
          builder: (context) => TaskDialog(
                  task: Task(
                task: () => AuthApi.sendVerificationLink(emailId),
                cancelable: false,
                runningLabel: 'Sending Link',
                failureLabel: 'Unable to send link',
                successLabel: 'Succesfully sent link',
                successConsent: false,
              )));

      if (result != null) {
        Navigator.of(context).pushReplacementNamed('emailsent');
      }
    }
  }
}
