import 'package:flutter/material.dart';
import 'package:onemovies/screens/main_page.dart';
import 'package:onemovies/screens/sign_in.dart';
import 'package:onemovies/utils/appwrite/auth.dart';
import 'package:onemovies/utils/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp());

  runApp(ChangeNotifierProvider(create: ((context) => Auth()), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final value = context.watch<Auth>().status;
    // final user = context.watch<Auth>().currentUser;
    // print(value);
    return MaterialApp(
      title: 'One Movies',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      // home: const HomeScreen(title: 'One Movies'),
      home: value == AuthStatus.uninitialized
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : value == AuthStatus.authenticated
          ? const MainPage()
          : const SignIn(),
    );
  }
}
