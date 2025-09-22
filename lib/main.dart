import 'package:flutter/material.dart';
import 'package:onemovies/screens/sign_in.dart';
import 'package:onemovies/screens/sign_up.dart';
import 'package:onemovies/utils/theme/theme.dart';

// import 'package:onemovies/screens/home.dart';
// import 'package:onemovies/screens/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      // home: const HomeScreen(title: 'One Movies'),
      home: const SignIn(),
    );
  }
}

