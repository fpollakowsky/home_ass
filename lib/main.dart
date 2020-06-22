import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villains/villains.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_ass/pages/onBoard/onBoardFirst.dart';
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
    DEBUG ?? print("INFO:: DEBUG MODE ACTIVE");
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
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]
    );

    return Material(
      child: Container(
        color: themeColor,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(32),
                  child: Image(
                    image: AssetImage(
                        "lib/assets/images/nethcon-logo.png"
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}