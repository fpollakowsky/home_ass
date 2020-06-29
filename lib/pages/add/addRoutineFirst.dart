import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:home_ass/components/singleAddDevice.dart';
import 'package:home_ass/components/singleAddRoutine.dart';
import 'package:home_ass/components/singleAddRoutineDevice.dart';
import 'package:home_ass/components/singleRoom.dart';
import 'package:home_ass/pages/home.dart';
import 'package:home_ass/pages/home/routines.dart';
import 'package:home_ass/pages/onBoard/onBoardGender.dart';
import 'package:home_ass/utils/mysql/updateRequest.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:home_ass/utils/res/transitions.dart';
import 'package:intl/intl.dart';

class AddRoutineFirst extends StatefulWidget{
  _AddRoutineFirst createState() => _AddRoutineFirst();
}

class _AddRoutineFirst extends State<AddRoutineFirst> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: themeColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  "Select Device",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  )
                )
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  width: double.infinity,
                  height: 170,
                  child: SingleAddRoutine(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: ButtonTheme(
                  height: 40,
                  minWidth: double.infinity,
                  child: FlatButton(
                    color: primaryColor,
                    textColor: Colors.white,
                    onPressed: (){
                      Navigator.of(context).push(FadeRouteBuilder(page: OnBoardGender()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("Next"),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}