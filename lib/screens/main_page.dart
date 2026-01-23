import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/screens/tabs/category_tab.dart';
import 'package:onemovies/screens/tabs/home_tab.dart';
import 'package:onemovies/screens/tabs/profile_tab.dart';
import 'package:onemovies/screens/tabs/schedule_tab.dart';
import 'package:onemovies/screens/tabs/search_tab.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _currentTabIndex = 0;

  final List<Widget> widgetList = [
    HomeTab(),
    SearchTab(),
    ScheduleTab(),
    CategoryTab(),
    ProfileTab(),
  ];

  
@override
void initState() {
  super.initState();
  SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF02111F),
    systemNavigationBarIconBrightness: Brightness.light,
  ),
);
}

@override
void dispose() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  super.dispose();
}

  void _onTabTapped(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: widgetList.elementAt(_currentTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xffD7263D),
        unselectedItemColor: colors.onSurface,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            icon: Icon(Broken.search_status_1),
            label: "Schedule",
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
