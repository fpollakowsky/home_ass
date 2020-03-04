import 'package:flutter/material.dart';
import 'package:home_ass/components/customScrollBehavior.dart';
import 'package:home_ass/pages/home/dashboard.dart';
import 'package:home_ass/pages/home/routines.dart';
import 'package:home_ass/utils/res/colors.dart';

void main() => runApp(TabBar());

class TabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eHome Concepts Design Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: child,
        );
      },
      home: MyTabBar(),
    );
  }
}

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>
  with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 0;
  static ScrollController _scrollViewController;
  List<Widget> _widgetOptions = <Widget>[
    Dashboard2(),
    Routines(),
    Dashboard2()
  ];

  @override
  void initState() {
  super.initState();
  _selectedIndex = 1;
  _tabController = TabController(vsync: this, length: 2);
  _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }
  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: primaryColor,
          currentIndex: _selectedIndex,
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.device_hub),
              title: Text('Routines'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        )
    );
  }
}