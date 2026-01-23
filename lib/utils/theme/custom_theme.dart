import 'package:flutter/material.dart';

class AppTheme {
  // 🔆 LIGHT THEME
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xffF5F5F5),

    colorScheme: const ColorScheme.light(
      primary: Color(0xffD7263D),
      secondary: Color(0xff1B9AAA),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Ubuntu',
        fontSize: 16,
      ),
    ),
  );

  // 🌙 DARK THEME
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xff02111F),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xffD7263D),
      secondary: Color(0xff1B9AAA),
      surface:  Color(0xff02111F),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xffEAEAEA),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff0A1E33),
      foregroundColor: Color(0xffEAEAEA),
      elevation: 0,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Ubuntu',
        fontSize: 16,
      ),
    ),
  );
}
