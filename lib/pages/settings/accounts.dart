import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/styles.dart';

final List<String> topicList = <String>['Setup Devices','Gateway','Privacy','Bug Report','Other'];

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPage createState() => new _AccountsPage();
}

class _AccountsPage extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Material(
      color: themeColor,
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  "Account Management",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: labelColor,
                      decoration: TextDecoration.none
                  )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}