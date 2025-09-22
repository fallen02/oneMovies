import 'package:flutter/material.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _passwordHidden = false;

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void handleSubmit() {
    print(_email);
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
                  "Sign In",
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

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: handleSubmit,
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
                      "Sign In",
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
                Expanded(child: Divider(color: Color.fromARGB(255, 95, 95, 95),)),

                Text("Or Continue with", style: TextStyle(fontSize: 15, fontFamily: 'Ubuntu'),),

                Expanded(child: Divider(color: Color.fromARGB(255, 95, 95, 95),)),
              ],
            ),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: handleSubmit,
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
                Text("Don't have an acount?", style: TextStyle(fontFamily: 'Ubuntu', fontSize: 15, color: Color(0xffEAEAEA)),),
                GestureDetector(
                  onTap: () {
                    print("tapped");
                  },
                  child: Text("Sign Up", style: TextStyle(fontFamily: 'Ubuntu', fontSize: 15, color: Color(0xffD7263D)),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
