import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/utils/res/colors.dart';

// TODO Add devices to database and shared pref

class AddDevicePage extends StatefulWidget {
  @override
  _AddDevicePage createState() => new _AddDevicePage();
}

class _AddDevicePage extends State<AddDevicePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryDarkColor,
      child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
              ],
            ),
          )
      ),
    );
  }
}