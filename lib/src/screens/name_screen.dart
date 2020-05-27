import '../provider.dart';
import '../utils/utils.dart';
import '../views/views.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> with ScreenUtilStateMixin {
  final _formKey = GlobalKey<FormState>();
  String name;
  String emailId;

  @override
  Widget build(BuildContext context) {
    emailId = ModalRoute.of(context).settings.arguments;
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
                        if (Validators.name(text)) return null;
                        return 'Name should be atleast of length 3';
                      },
                      onSaved: (text) => this.name = text,
                      decoration:
                          InputDecoration(labelText: 'Name', hintText: 'Name'),
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
                              _sendLink();
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
            Provider.of(context).storeName(name);
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
