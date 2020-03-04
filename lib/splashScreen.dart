import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villain.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_ass/pages/onBoard/1.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorObservers: [VillainTransitionObserver()],
    theme: ThemeData(
      textTheme: GoogleFonts.varelaTextTheme(
      )
    ),
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget{
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  startTimeout([int milliseconds]) {
    Timer(Duration(milliseconds: 1500), () {
      if (valFirstStart == null){
        initFirstSetup();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OnBoardFirst()));
      }
      else{
        initDashboard(context, true);
      }
    });
  }

  @override
  void initState(){
    super.initState();
    loadSharedPreferences().then((val){
      startTimeout();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Material(
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
    );
  }
}