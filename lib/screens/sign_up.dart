import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/auth_provider.dart';
import 'package:onemovies/screens/sign_in.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  bool _passwordHidden = false;
  bool _repeatPasswordHidden = false;

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _repeatPassword;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _repeatPassword = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _repeatPassword.dispose();
    super.dispose();
  }

  Future<void> handleSignUp() async {
    if (_password.text != _repeatPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await ref
          .read(authProvider.notifier)
          .createUserWithPasswordandEmail(
            email: _email.text.trim(),
            password: _password.text.trim(),
          );

      if (mounted) Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignIn()),
      );
    } on AppwriteException catch (e) {
      if (mounted) Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Signup failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
        child: Column(
          spacing: 20,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Broken.arrow_left_2, size: 30),
                ),
              ],
            ),

            Column(
              spacing: 20,
              children: const [
                Image(image: AssetImage('assets/icons/icon.png'), width: 150),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Column(
              spacing: 20,
              children: [
                TextField(
                  controller: _email,
                  textAlign: TextAlign.start,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Email...',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Broken.user, size: 20),
                    prefixIconColor: WidgetStateColor.resolveWith(
                      (states) => states.contains(WidgetState.focused)
                          ? Color(0xffD7263D)
                          : Color(0xffEAEAEA),
                    ),
                    labelText: 'Your Email',
                    labelStyle: TextStyle(fontFamily: 'Ubuntu', fontSize: 15),
                    floatingLabelStyle: TextStyle(color: Color(0xffD7263D)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7263D)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7263D)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusColor: Color(0xffD7263D),
                  ),
                ),
                TextField(
                  controller: _password,
                  textAlign: TextAlign.start,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: !_passwordHidden,
                  decoration: InputDecoration(
                    hintText: 'Enter Password...',
                    prefixIcon: Icon(Broken.check, size: 20),
                    prefixIconColor: WidgetStateColor.resolveWith(
                      (states) => states.contains(WidgetState.focused)
                          ? Color(0xffD7263D)
                          : Color(0xffEAEAEA),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordHidden = !_passwordHidden;
                          });
                        },
                        icon: Icon(
                          _passwordHidden ? Broken.eye : Broken.eye_slash,
                          size: 20,
                        ),
                      ),
                    ),
                    suffixIconColor: WidgetStateColor.resolveWith(
                      (states) => states.contains(WidgetState.focused)
                          ? Color(0xffD7263D)
                          : Color(0xffEAEAEA),
                    ),
                    labelText: 'Your Password',
                    labelStyle: TextStyle(fontFamily: 'Ubuntu', fontSize: 15),
                    floatingLabelStyle: TextStyle(color: Color(0xffD7263D)),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7263D)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7263D)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusColor: Color(0xffD7263D),
                  ),
                ),
                
                 TextField(
                  controller: _repeatPassword,
                  textAlign: TextAlign.start,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: !_repeatPasswordHidden,
                  decoration: InputDecoration(
                    hintText: 'Enter Password...',
                    prefixIcon: Icon(Broken.check, size: 20),
                    prefixIconColor: WidgetStateColor.resolveWith(
                      (states) => states.contains(WidgetState.focused)
                          ? Color(0xffD7263D)
                          : Color(0xffEAEAEA),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                          _repeatPasswordHidden =
                              !_repeatPasswordHidden;
                        });
                        },
                        icon: Icon(
                           _repeatPasswordHidden
                            ? Broken.eye
                            : Broken.eye_slash,
                        ),
                      ),
                    ),
                    suffixIconColor: WidgetStateColor.resolveWith(
                      (states) => states.contains(WidgetState.focused)
                          ? Color(0xffD7263D)
                          : Color(0xffEAEAEA),
                    ),
                    labelText: 'Repeat Password',
                    labelStyle: TextStyle(fontFamily: 'Ubuntu', fontSize: 15),
                    floatingLabelStyle: TextStyle(color: Color(0xffD7263D)),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7263D)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD7263D)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusColor: Color(0xffD7263D),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleSignUp,
                    child: const Text("Sign Up"),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignIn(),
                      ),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Color(0xffD7263D)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
