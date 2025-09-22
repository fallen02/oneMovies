import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            spacing: 50,
            children: [
              Image.network(
                'https://placehold.co/400x600.png',
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : LinearProgressIndicator(
                          backgroundColor: Color(0xffD7263D),
                        );
                },
              ),
              Column(
                spacing: 25,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffEAEAEA),
                          ),
                          text: "Welcome to ",
                          children: [
                            TextSpan(
                              style: TextStyle(color: Color(0xffD7263D)),
                              text: "OneApp",
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Just sit back and relax",
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 20, color: Color.fromARGB(255, 107, 107, 107)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        // isSemanticButton: ,
                        onPressed: () {},
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
                          "Watch Now",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color(0xffEAEAEA),
                          ),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  // side: BorderSide(color: Colors.red),
                                ),
                              ),
                          foregroundColor: WidgetStatePropertyAll(
                            Color(0xffD7263D),
                          ),
                          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                            EdgeInsetsGeometry.fromLTRB(30, 10, 30, 10),
                          ),
                        ),
                        child: Text(
                          "Login Now",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                  // Text("w")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
