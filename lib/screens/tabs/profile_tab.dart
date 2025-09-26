import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // mainAxisAlignment: MainAxisAlignment.center,
        child: 
          Text("Profile Tab", style: TextStyle(fontSize: 50, fontFamily: 'Ubuntu'),)
        ,
      ),
    );
  }
}