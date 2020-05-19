import 'package:flutter/material.dart';
import 'src/screens/screens.dart';
import 'src/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Feather',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
