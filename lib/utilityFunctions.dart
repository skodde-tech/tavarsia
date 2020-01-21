import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// Get the screen size
/// @param context for how it will building.
/// @return the size
///
Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

///
/// Get the screen height
/// @param context for how it will building.
/// @param what we divide by, default set to 1
/// @return a height
///
double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

///
/// Get the screen width
/// @param context for how it will building.
/// @param what we divide by, default set to 1
/// @return a width
///
double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

///
/// Functions for launching a url
/// @param the url we want to launch
///
launchURL(String url) async {
  // Check if it can be launched,
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// ################# Variables under should maybe not be here.
/// Primary color of the app
Map<int, Color> primaryColor = {
  50: Color.fromRGBO(62, 89, 153, .1),
  100: Color.fromRGBO(62, 89, 153, .2),
  200: Color.fromRGBO(62, 89, 153, .3),
  300: Color.fromRGBO(62, 89, 153, .4),
  400: Color.fromRGBO(62, 89, 153, .5),
  500: Color.fromRGBO(62, 89, 153, .6),
  600: Color.fromRGBO(62, 89, 153, .7),
  700: Color.fromRGBO(62, 89, 153, .8),
  800: Color.fromRGBO(62, 89, 153, .9),
  900: Color.fromRGBO(62, 89, 153, 1),
};

/// Button colors of the app
Map<int, Color> buttonColor = {
  50: Color.fromRGBO(43, 17, 40, .1),
  100: Color.fromRGBO(43, 17, 40, .2),
  200: Color.fromRGBO(43, 17, 40, .3),
  300: Color.fromRGBO(43, 17, 40, .4),
  400: Color.fromRGBO(43, 17, 40, .5),
  500: Color.fromRGBO(43, 17, 40, .6),
  600: Color.fromRGBO(43, 17, 40, .7),
  700: Color.fromRGBO(43, 17, 40, .8),
  800: Color.fromRGBO(43, 17, 40, .9),
  900: Color.fromRGBO(43, 17, 40, 1),
};

/// Our App Name
const String appName = 'Tavarsia';
