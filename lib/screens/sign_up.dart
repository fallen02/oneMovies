import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:onemovies/screens/sign_in.dart';
import 'package:onemovies/utils/appwrite/auth.dart';
import 'package:onemovies/utils/icon_fonts.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordHidden = false;
  bool _repeatpasswordHidden = false;

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _repeatPassword;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _repeatPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _repeatPassword.dispose();
    super.dispose();
  }

  void handleSignUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        );
      },
    );

    try {
      final Auth appwrite = context.read<Auth>();
      await appwrite.createUserWithPasswordandEmail(
        email: _email.text,
        password: _password.text,
      );
      Navigator.pop(context);
      const snackbar = SnackBar(content: Text("account created"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    } on AppwriteException catch (e) {
      Navigator.pop(context);
      final snackbar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 50),

        // alignment: Alignment.topCenter,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Broken.arrow_left_2,
                    size: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Image.network(
                  'https://placehold.co/150.png',
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : LinearProgressIndicator(
                            backgroundColor: Color(0xffD7263D),
                          );
                  },
                ),

                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
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
                  obscureText: !_repeatpasswordHidden,
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
                            _repeatpasswordHidden = !_repeatpasswordHidden;
                          });
                        },
                        icon: Icon(
                          _repeatpasswordHidden ? Broken.eye : Broken.eye_slash,
                          size: 20,
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
                  child: TextButton(
                    onPressed: handleSignUp,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xffD7263D),
                      ),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // side: BorderSide(color: Colors.red),
                        ),
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        Color(0xffEAEAEA),
                      ),
                      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsetsGeometry.fromLTRB(30, 10, 30, 10),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 20,
                        // fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: Color(0xffEAEAEA),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              spacing: 20,
              children: <Widget>[
                Expanded(
                  child: Divider(color: Color.fromARGB(255, 95, 95, 95)),
                ),

                Text(
                  "Or Continue with",
                  style: TextStyle(fontSize: 15, fontFamily: 'Ubuntu'),
                ),

                Expanded(
                  child: Divider(color: Color.fromARGB(255, 95, 95, 95)),
                ),
              ],
            ),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: handleSignUp,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromARGB(115, 93, 93, 94),
                  ),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Color.fromARGB(169, 101, 102, 102),
                      ),
                    ),
                  ),
                  // foregroundColor: WidgetStatePropertyAll(Color(0xffEAEAEA)),
                  padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                    EdgeInsetsGeometry.fromLTRB(30, 10, 30, 10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 15,
                  children: [
                    Image(
                      image: AssetImage('assets/icons/google-icon.png'),
                      fit: BoxFit.scaleDown,
                      width: 25,
                    ),
                    // ImageIcon(AssetImage('assets/icons/google-icon.png'), color: Color.fromARGB(255, 215, 38, 62),),
                    Text(
                      "Continue with Google",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                        color: Color(0xffEAEAEA),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              spacing: 3,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 15,
                    color: Color(0xffEAEAEA),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      color: Color(0xffD7263D),
                    ),
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
