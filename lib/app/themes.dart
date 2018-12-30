import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/colors.dart';

final primaryTextTheme = TextTheme(
  body1: TextStyle(color: Colors.white, fontSize: 15.0),
  title: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.w600),
  headline: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w600),
  caption: TextStyle(color: Colors.white, fontSize: 12.0),
  subtitle: TextStyle(color: Colors.white, fontSize: 22.0),
);

final textTheme = TextTheme(
  body1: TextStyle(color: Colors.white, fontSize: 15.0),
  title: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
  headline: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w600),
  caption: TextStyle(color: Colors.white, fontSize: 12.0),
  subtitle: TextStyle(color: Colors.white, fontSize: 22.0),
);


final shiffrThemeData = ThemeData(
    brightness: Brightness.dark,
    primaryTextTheme: primaryTextTheme,
    textTheme: textTheme,
    primaryColor: ShiffrColors.primary,
    cardColor: ShiffrColors.cardBlue,
    primaryColorBrightness: Brightness.dark,
//            primaryColorDark: Color(0xFF3F88C5),
    accentColor: ShiffrColors.accent,
    scaffoldBackgroundColor: ShiffrColors.bgBlue,
//            bottomAppBarColor: Color(0xFF0A1B32),
    buttonColor: ShiffrColors.btnBlue,
    disabledColor: ShiffrColors.disabledColor,
    tabBarTheme: TabBarTheme(labelColor: Colors.amber));