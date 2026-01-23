import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:onemovies/constants/appwrite.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final User? user;

  const AuthState({
    required this.status,
    this.user,
  });

  String? get username => user?.name;
  String? get email => user?.email;
  String? get userId => user?.$id;
}

// class Auth extends ChangeNotifier {
//   Client client = Client();
//   late final Account account;
//   late User _currentUser;

//   AuthStatus _status = AuthStatus.uninitialized;

//   //Getters
//   User get currentUser => _currentUser;
//   AuthStatus get status => _status;
//   String? get username => _currentUser.name;
//   String? get email => _currentUser.email;
//   String? get userId => _currentUser.$id;

//   //Constractor
//   Auth() {
//     init();
//     loadUser();
//   }

//   // initialize
//   Future<void> init() async {
//     client
//         .setEndpoint(APPWRITE_URL)
//         .setProject(APPWRITE_PROJECT_ID)
//         .setSelfSigned();

//     account = Account(client);
//   }

//   Future<void> loadUser() async {
//     try {
//       final user = await account.get();
//       _status = AuthStatus.authenticated;
//       _currentUser = user;
//     } catch (e) {
//       _status = AuthStatus.unauthenticated;
//     }finally {
//       notifyListeners();
//     }
//   }

//   //functions
//   Future<User> createUserWithPasswordandEmail({
//     required String email,
//     required String password,
//   }) async {
//     // notifyListeners();

//     try {
//       final user = await account.create(
//         userId: ID.unique(),
//         email: email,
//         password: password,
//       );
//       return user;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<Session> loginWithEmailandPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final session = await account.createEmailPasswordSession(
//         email: email,
//         password: password,
//       );
//       _currentUser = await account.get();
//       _status = AuthStatus.authenticated;
//       return session;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<Session> signInWithProvider({required OAuthProvider provider}) async {
//     try {
//       final session = await account.createOAuth2Session(provider: provider);
//       _currentUser = await account.get();
//       _status = AuthStatus.authenticated;
//       return session;
//     } finally {
//       notifyListeners();
//     }
//   }

//   dynamic signOut() async {
//     try {
//       await account.deleteSession(sessionId: 'current');
//       _status = AuthStatus.unauthenticated;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<Preferences> getUserPreferrnces() async {
//     return await account.getPrefs();
//   }

//   dynamic updatePreferences({required String bio}) async {
//     return account.updatePrefs(prefs: {'bio': bio});
//   }
// }

class AuthNotifier extends StateNotifier<AuthState> {
  late final Client client;
  late final Account account;

  AuthNotifier()
      : super(const AuthState(
          status: AuthStatus.uninitialized,
        )) {
    _init();
  }

  Future<void> _init() async {
    client = Client()
        .setEndpoint(APPWRITE_URL)
        .setProject(APPWRITE_PROJECT_ID)
        .setSelfSigned();

    account = Account(client);
    await loadUser();
  }

  Future<void> loadUser() async {
    try {
      final user = await account.get();
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
    } catch (_) {
      state = const AuthState(
        status: AuthStatus.unauthenticated,
      );
    }
  }

  Future<User> createUserWithPasswordandEmail({
    required String email,
    required String password,
  }) async {
    return await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
    );
  }

  Future<Session> loginWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    final session = await account.createEmailPasswordSession(
      email: email,
      password: password,
    );

    final user = await account.get();
    state = AuthState(
      status: AuthStatus.authenticated,
      user: user,
    );

    return session;
  }

  Future<Session> signInWithProvider({
    required OAuthProvider provider,
  }) async {
    final session =
        await account.createOAuth2Session(provider: provider);

    final user = await account.get();
    state = AuthState(
      status: AuthStatus.authenticated,
      user: user,
    );

    return session;
  }

  Future<void> signOut() async {
    await account.deleteSession(sessionId: 'current');
    state = const AuthState(
      status: AuthStatus.unauthenticated,
    );
  }

  Future<Preferences> getUserPreferences() async {
    return account.getPrefs();
  }

  Future<void> updatePreferences({required String bio}) async {
    await account.updatePrefs(prefs: {'bio': bio});
  }
}