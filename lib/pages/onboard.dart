import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_ass/main.dart';
import 'package:home_ass/utils/res/colors.dart';

void main() => runApp(OnBoard());

class OnBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: _OnBoard()
    );
  }
}

class _OnBoard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image(image: AssetImage("lib/assets/onBoardImage.png")),
            ),
            Text("Smart Home", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: Colors.black)),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text("Manage your home by using phone everywhere", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey), textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32))
                ),
                onPressed: (){
                  Navigator.pushReplacement(context ,MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
                },
                child: Text("Get Started", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
              ),
            ),
            Image(image: AssetImage("lib/assets/onBoardBottom.png"))
          ],
        ),
      ),
    );
  }
}