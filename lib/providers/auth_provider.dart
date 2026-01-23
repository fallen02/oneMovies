import 'package:flutter_riverpod/legacy.dart';
import 'package:onemovies/utils/appwrite/auth.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
