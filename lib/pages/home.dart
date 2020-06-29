import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/pages/home/dashboard.dart';
import 'package:home_ass/pages/home/routines.dart';
import 'package:home_ass/pages/home/settings.dart';
import 'package:home_ass/utils/res/colors.dart';

class HomeScreen extends StatefulWidget {
  @required
  final int index;
  final int error;
  HomeScreen({
    this.index,
    this.error
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex = 1;
  static ScrollController _scrollViewController;

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
    final int error = widget.error;

    List<Widget> _widgetOptions = <Widget>[
      Routines(),
      Dashboard2(error: error,),
      Settings()
    ];

    return Scaffold(
      //backgroundColor: secondaryColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.device_hub),
            title: Text('Routines'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
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
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}