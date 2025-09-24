import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:onemovies/constants/appwrite.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated }

class Auth extends ChangeNotifier {
  Client client = Client();
  late final Account account;
  late User _currentUser;

  AuthStatus _status = AuthStatus.uninitialized;

  //Getters
  User get currentUser => _currentUser;
  AuthStatus get status => _status;
  String? get username => _currentUser.name;
  String? get email => _currentUser.email;
  String? get userId => _currentUser.$id;

  //Constractor
  Auth() {
    init();
    loadUser();
  }

  // initialize
  Future<void> init() async {
    client
        .setEndpoint(APPWRITE_URL)
        .setProject(APPWRITE_PROJECT_ID)
        .setSelfSigned();

    account = Account(client);
  }

  Future<void> loadUser() async {
    try {
      final user = await account.get();
      _status = AuthStatus.authenticated;
      _currentUser = user;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    }finally {
      notifyListeners();
    }
  }

  //functions
  Future<User> createUserWithPasswordandEmail({
    required String email,
    required String password,
  }) async {
    // notifyListeners();

    try {
      final user = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return user;
    } finally {
      notifyListeners();
    }
  }

  Future<Session> loginWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      final session = await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
      return session;
    } finally {
      notifyListeners();
    }
  }

  Future<Session> signInWithProvider({required OAuthProvider provider}) async {
    try {
      final session = await account.createOAuth2Session(provider: provider);
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
      return session;
    } finally {
      notifyListeners();
    }
  }

  dynamic signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  Future<Preferences> getUserPreferrnces() async {
    return await account.getPrefs();
  }

  dynamic updatePreferences({required String bio}) async {
    return account.updatePrefs(prefs: {'bio': bio});
  }
}
