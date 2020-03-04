import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/pages/home/dashboard.dart';
import 'package:home_ass/pages/home/routines.dart';
import 'package:home_ass/pages/home/settings.dart';
import 'package:home_ass/utils/res/colors.dart';

class HomeScreen extends StatefulWidget {
  @required
  final int index;

  HomeScreen({
    this.index
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 0;
  static ScrollController _scrollViewController;
  List<Widget> _widgetOptions = <Widget>[
    Dashboard2(),
    Routines(),
    Settings()
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
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
      backgroundColor: secondaryColor,
        bottomNavigationBar: BottomNavigationBar(
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
