import '../provider.dart';
import '../utils/screen_utils.dart';
import 'package:flutter/material.dart';
import '../platform/feather.dart';
import '../views/views.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with ScreenUtilStateMixin {
  String emailId;
  String name;
  String link;
  @override
  void initState() {
    super.initState();
    final provider = Provider.of(context);
    emailId = provider.fetchEmailId();
    name = provider.fetchName();
    Feather.instance.onIntent(onLinkArrived);
  }

  void onLinkArrived(String link) async {
    this.link = link;
    _verifyLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(sw(20)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            name != null
                ? Text(
                    'Hello $name',
                    style: Theme.of(context).textTheme.headline5,
                  )
                : vGap(0),
            vGap(16),
            Text(
              'We have sent a link to your $emailId, open the link in this app',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  void _verifyLink() async {
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
        title: 'Verifying Link',
        task: () async {
          final response = await Provider.of(context)
              .verifyEmailLink(emailId, link, name: name);
          if (response.isSuccessful) {
            Provider.of(context).storeEmailId(null);
            Provider.of(context).storeName(null);
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/home');
          } else
            Slide.of(context).add(builder: _failureDialog);
        },
      );

  Widget _failureDialog(BuildContext context) => FeatherDialog(
        title: 'Unable to verify link',
        running: false,
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Resend Link'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      );
}
