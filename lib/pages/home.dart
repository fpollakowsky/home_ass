import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/pages/bottom-bar//dashboard.dart';
import 'package:home_ass/pages/bottom-bar/settings.dart';
import 'package:home_ass/pages/bottom-bar/scenes.dart';
import 'package:home_ass/utils/res/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  static ScrollController _scrollViewController;
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    DashboardIndex(),
    ScenesIndex(),
    SettingsIndex()
  ];

  @override
  void initState() {
    super.initState();
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
      backgroundColor: primaryDarkColor,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.device_hub),
              title: Text('Scenes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          onTap: _onItemTapped,
        ),
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        )
    );
  }
}