import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'src/screens/screens.dart';
import 'src/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Feather',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Color(0xffffdd77),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: Color(0xff191919),
          brightness: Brightness.dark,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
              borderRadius: BorderRadius.circular(2),
              gapPadding: 4,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(2),
              gapPadding: 4,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.orange),
              borderRadius: BorderRadius.circular(2),
              gapPadding: 4,
            ),
            hintStyle: TextStyle(color: Colors.white.withAlpha(92)),
            labelStyle: TextStyle(color: Colors.white),
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.transparent,
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
              ),
            ),
            iconTheme: IconThemeData(size: 32),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) {
            context.initScreenUtil();
            return SplashScreen();
          },
          '/name': (context) => NameScreen(),
          '/login': (context) => LoginScreen(),
          '/verification': (context) => VerificationScreen(),
          '/home': (context) {
            return HomeScreen();
          },
        },
      ),
    );
  }
}

extension on BuildContext {
  void initScreenUtil() {
    ScreenUtil.init(this,
        allowFontScaling: true,
        width: 400,
        height: 400 / MediaQuery.of(this).size.aspectRatio);
  }
}
