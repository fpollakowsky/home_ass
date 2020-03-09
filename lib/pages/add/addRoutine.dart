import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:home_ass/components/singleAddDevice.dart';
import 'package:home_ass/components/singleAddRoutineDevice.dart';
import 'package:home_ass/pages/home.dart';
import 'package:home_ass/pages/home/routines.dart';
import 'package:home_ass/utils/mysql/updateRequest.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:intl/intl.dart';

String txtGateway,routineTitle,routineWeekdays,routineStartTime,routineEndTime;
List<dynamic> routineAction;
List<List<dynamic>> selectDays = [
  ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  [unselectedBoxColor,unselectedBoxColor,unselectedBoxColor,unselectedBoxColor,primaryColor,unselectedBoxColor,unselectedBoxColor],
  [unselectedTextColor,unselectedTextColor,unselectedTextColor,unselectedTextColor,Colors.white,unselectedTextColor,unselectedTextColor]
];

class AddRoutine extends StatefulWidget{
  _AddRoutine createState() => _AddRoutine();
}

class _AddRoutine extends State<AddRoutine> {
  final formKeyRoutine  = GlobalKey<FormState>();
  String startTime = "00:00";
  String endTime = "00:00";
  double addDeviceContainerHeight = 48;

  setRoutineDays(){
    for(var i = 0; i <= 6; i++){
      if(routineWeekdays != null){
        if (selectDays[1][i] == unselectedBoxColor){
          routineWeekdays = routineWeekdays + ',"0"';
        }else{
          routineWeekdays = routineWeekdays + ',"1"';
        }
      }else{
        if (selectDays[1][i] == unselectedBoxColor){
          routineWeekdays = '"0"';
        }else{
          routineWeekdays = '"1"';
        }
      }
    }
  }
  setRoutineTime(){
    routineStartTime = "2020-01-01 " + startTime + ":00";
    routineEndTime = "2020-01-01 " + endTime + ":00";
  }
  changeState(int index){
    if (selectDays[1][index] == primaryColor){
      selectDays[1][index] = unselectedBoxColor;
      selectDays[2][index] = unselectedTextColor;
    }else{
     selectDays[1][index] = primaryColor;
     selectDays[2][index] = Colors.white;
    }
  }
  startTimeout([int milliseconds]) {
    Timer(Duration(seconds: 5), () {
      initDashboard(context, true);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: secondaryColor
    ));
    return Material(
      color: themeColor,
      child: SafeArea(
        child: Form(
          key: formKeyRoutine,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 8,left: 8, right: 8),
                color: secondaryColor,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back,color: Colors.white),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Add Routine",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      letterSpacing: 2
                                  ),
                                )
                            )
                        ),
                        Container(
                          width: 32,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16,left: 16,right: 16),
                child: Text(
                  "Schedule",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                  ),
                ),
              ),
              // txt name
              Container(
                margin: EdgeInsets.only(top: 16,left: 16,right: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor,width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green,width: 2)
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red,width: 2)
                    ),
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onSaved: (value){
                    routineTitle = value;
                  },
                ),
              ),
              // select time
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 32,left: 16,right: 16),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Start Time",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey
                                  )
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    DatePicker.showTimePicker(context,
                                        showTitleActions: true,
                                        onConfirm: (val) {
                                          setState(() {
                                            var date = DateFormat.Hm().format(val);
                                            startTime = date;
                                          });
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.de
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      startTime,
                                      style: TextStyle(
                                          color: labelColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 32,left: 16,right: 16),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "End Time",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey
                                  )
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    DatePicker.showTimePicker(context,
                                        showTitleActions: true,
                                        onConfirm: (val) {
                                          setState(() {
                                            var date = DateFormat.Hm().format(val);
                                            endTime = date;
                                          });
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      endTime,
                                      style: TextStyle(
                                        color: labelColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // select day
              Container(
                margin: EdgeInsets.only(top: 16,left: 16,right: 16),
                child: Text(
                  "Select Day",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                  ),
                ),
              ),
              Container(
                height: 56,
                margin: EdgeInsets.only(top: 8,left: 16,right: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectDays[1].length,
                  itemBuilder: (BuildContext context, int index){
                    return Material(
                      type: MaterialType.card,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            changeState(index);
                          });
                        },
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                            width: 48,
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: selectDays[1][index],
                                borderRadius: BorderRadius.all(Radius.circular(100))
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                selectDays[0][index],
                                style: TextStyle(
                                    color: selectDays[2][index]
                                ),
                              ),
                            )
                        ),
                      ),
                    );
                  }
                )
              ),
              AnimatedContainer(
                  height: addDeviceContainerHeight,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInSine,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: double.infinity,
                        child: FlatButton(
                          color: primaryColor,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(16)),
                          onPressed: (){
                            setState(() {
                              addDeviceContainerHeight == 48 ? addDeviceContainerHeight = 258 : addDeviceContainerHeight = 48;
                            });
                          },
                          child: Text(
                            "Possible Devices",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Text(
                        "Klick on device to add to routine",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        width: double.infinity,
                        height: 170,
                        child: SingleAddRoutineDevice(),
                      )
                    ],
                  )
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 16,right: 16),
                    child: SingleRoutineAddedDevice()
                ),
              ),
              // save button
              Container(
                margin: EdgeInsets.all(16),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 40,
                  child: FlatButton(
                    color: primaryColor,
                    onPressed: (){
                      if (formKeyRoutine.currentState.validate()) {
                        formKeyRoutine.currentState.save();
                        setRoutineDays();
                        setRoutineTime();
                        insertRoutineInformation(routineTitle, '['+routineWeekdays+']', jsonEncode(addRoutineDevice), routineStartTime, routineEndTime);

                        txtGateway = null;
                        routineTitle = null;
                        routineWeekdays = null;
                        routineStartTime = null;
                        routineAction = null;

                        setRoutinesInformation().then((val){
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}