import 'package:flutter/material.dart';
import 'package:onemovies/screens/tabs/category_tab.dart';
import 'package:onemovies/screens/tabs/home_tab.dart';
import 'package:onemovies/screens/tabs/profile_tab.dart';
import 'package:onemovies/screens/tabs/search_tab.dart';
import 'package:onemovies/utils/appwrite/auth.dart';
import 'package:onemovies/utils/icon_fonts.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentTabIndex = 0;

  final List<Widget> widgetList = [
    HomeTab(),
    SearchTab(),
    CategoryTab(),
    ProfileTab(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  void handleSignOut() async {
    final Auth auth = context.read<Auth>();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList.elementAt(_currentTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xffD7263D),
        unselectedItemColor: Color.fromARGB(255, 87, 85, 85),
        backgroundColor: Color.fromARGB(255, 2, 17, 31),
        iconSize: 20,
        selectedFontSize: 11,
        unselectedFontSize: 10,
        selectedLabelStyle: TextStyle(fontFamily: 'Ubuntu'),
        unselectedLabelStyle: TextStyle(fontFamily: 'Ubuntu'),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Broken.home_2), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Broken.search_normal),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Broken.category),
            label: "Category",
          ),
          BottomNavigationBarItem(icon: Icon(Broken.user), label: "Profile"),
        ],
        currentIndex: _currentTabIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
