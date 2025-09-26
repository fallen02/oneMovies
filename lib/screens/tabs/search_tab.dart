import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // mainAxisAlignment: MainAxisAlignment.center,
        child: 
          Text("Search Tab", style: TextStyle(fontSize: 50),)
        ,
      ),
    );
  }
}