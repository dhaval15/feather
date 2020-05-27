import 'package:feather/src/provider.dart';
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
                          child: Text('Next'),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _checkUserAvailibilty();
                            }
                          },
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

  void _checkUserAvailibilty() async {
    final isFirstTimeUser = await Provider.of(context).isFirstTime(emailId);
    if (isFirstTimeUser.isSuccessful && isFirstTimeUser.result)
      Navigator.of(context).pushNamed('/name', arguments: emailId);
    else
      _sendLink();
  }

  void _sendLink() async {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Slide(
                builder: _runningDialog,
              ),
            ));
  }

  Widget _runningDialog(BuildContext context) => FeatherDialog(
        running: true,
        title: 'Sending Link',
        task: () async {
          final response =
              await Provider.of(context).sendVerificationLink(emailId);
          if (response.isSuccessful) {
            Provider.of(context).storeEmailId(emailId);
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/verification');
          } else
            Slide.of(context).add(builder: _failureDialog);
        },
      );

  Widget _failureDialog(BuildContext context) => FeatherDialog(
        title: 'Something went wrong',
        running: false,
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Retry'),
            onPressed: () {
              Slide.of(context).add(builder: _runningDialog);
            },
          ),
        ],
      );
}
