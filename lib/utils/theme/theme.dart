import 'package:flutter/material.dart';
// import 'package:onemovies/utils/theme/custom_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xffEAEAEA),
    primaryColor: Color(0xffD7263D),
    // TODO: create a textTheme with fonts
    // textTheme: TTextTheme.lightTextTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff02182B),
    primaryColor: Color(0xffD7263D),
    // TODO: create a textTheme with fonts
    // textTheme: TTextTheme.darkTextTheme,
  );
}
