import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'pages/home.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoard(),
  ));
}

class OnBoard extends StatefulWidget{
  _OnBoard createState() => _OnBoard();
}

class _OnBoard extends State<OnBoard> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: Material(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image(image: AssetImage("lib/assets/onBoardImage.png")),
              ),
              Text("Smart Home", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: Colors.black)),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text("Manage your home by using phone everywhere", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey), textAlign: TextAlign.center,),
                ),
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              Image(image: AssetImage("lib/assets/onBoardBottom.png"))
            ],
          ),
        ),
      )
    );
  }
}