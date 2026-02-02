import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/auth_provider.dart';
import 'package:onemovies/screens/main_page.dart';
import 'package:onemovies/screens/sign_in.dart';
import 'package:onemovies/utils/appwrite/auth.dart';
import 'package:onemovies/utils/theme/custom_theme.dart';


void main() {
  // runApp(const MyApp());

  // runApp(ChangeNotifierProvider(create: ((context) => Auth()), child: MyApp()));

  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final hasSeenOnboarding = ref.watch(onBoardingProvider);
    final authStatus = ref.watch(authProvider).status;

    return MaterialApp(
      title: 'One Movies',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: 
      // !hasSeenOnboarding
      //     ? const HomeScreen()
      //     : 
          authStatus == AuthStatus.uninitialized
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : authStatus == AuthStatus.authenticated
                  ? const MainPage()
                  : const SignIn(),
    );
  }
}

