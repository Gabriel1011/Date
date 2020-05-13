import 'package:flutter/material.dart';

const brightness = Brightness.dark;
const primaryColor = const Color(0xFFFF1493);
const lightColor = const Color(0xFFFFFFFF);
const backgroundColor = const Color(0xFFF5F5F5);

ThemeData pinkDarkTheme() {
  return ThemeData(
    // primarySwatch: primaryColor,
    brightness: brightness,
    textTheme: new TextTheme(
      body1: new TextStyle(
        fontFamily: "Staatliches",
      ),
      body2: TextStyle(
        fontFamily: "Staatliches",
      ),
      button: TextStyle(
        fontFamily: "Staatliches",
      ),
      caption: TextStyle(
        fontFamily: "Staatliches",
      ),
      display1: TextStyle(
        fontFamily: "Staatliches",
      ),
      display2: TextStyle(
        fontFamily: "Staatliches",
      ),
      display3: TextStyle(
        fontFamily: "Staatliches",
      ),
      display4: TextStyle(
        fontFamily: "Staatliches",
      ),
      headline: TextStyle(
        fontFamily: "Staatliches",
      ),
      overline: TextStyle(
        fontFamily: "Staatliches",
      ),
      subhead: TextStyle(
        fontFamily: "Staatliches",
      ),
      subtitle: TextStyle(
        fontFamily: "Staatliches",
      ),
      title: TextStyle(
        fontFamily: "Staatliches",
      ),
    ),
    // tabBarTheme:
    // accentIconTheme:
    // accentTextTheme:
    // appBarTheme:
    // bottomAppBarTheme:
    // buttonTheme: new ButtonThemeData(
    //   buttonColor: Colors.orange,
    //   textTheme: ButtonTextTheme.primary,
    // ),
    // cardTheme: CardTheme(
    //   elevation: 5,
    //   color: Colors.indigo,
    // ),
    // chipTheme:
    // dialogTheme:
    // floatingActionButtonTheme:
    iconTheme: IconThemeData(color: Colors.grey),
    // inputDecorationTheme:
    // pageTransitionsTheme:
    primaryIconTheme: IconThemeData(color: Colors.grey),
    // primaryTextTheme:
    // sliderTheme:
    primaryColor: primaryColor,
    accentColor: Colors.black87,
    // fontFamily: 'Montserrat',
    // buttonColor: Color(0xFF00C569),
    // // scaffoldBackgroundColor: backgroundColor,
    // cardColor: Colors.white,
  );
}
