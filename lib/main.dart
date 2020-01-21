import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utilityFunctions.dart';
import 'package:flutter_app/pages/home.dart';

/// Main functions that run the app
void main() => runApp(MyApp());

/// My App
class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //force portrait:
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
        //##############  Name on the app
        title: appName,

        //############## Theme for the app - design
        theme: ThemeData(

          //##### Text
            textTheme: TextTheme(
                button: TextStyle(color: Colors.white),
                body1: TextStyle(color: Colors.white)
            ),

          //##### Main colors
          backgroundColor: MaterialColor(0xff06074B, primaryColor),
          primarySwatch: MaterialColor(0xff3e5999, primaryColor),

          //##### Button
          buttonTheme: ButtonThemeData(
            buttonColor: MaterialColor(0xff854549, primaryColor),
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            //hoverColor:,
            //height:,
            //focusColor:,
            //shape,
          ),

      ),

      //################ Home Page
      home: HomePage(title: appName),
    );
  }
}
