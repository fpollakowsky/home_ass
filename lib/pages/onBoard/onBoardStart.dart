import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/onBoard/onBoardSearch.dart';
import 'package:home_ass/pages/onBoard/onBoardGender.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:home_ass/utils/res/transitions.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorObservers: [VillainTransitionObserver()],
    home: OnBoardStart(),
  ));
}

class OnBoardStart extends StatefulWidget{
  _OnBoardFirst createState() => _OnBoardFirst();
}

class _OnBoardFirst extends State<OnBoardStart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadSharedPreferences();
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Material(
        color: themeColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  height: 256,
                  width:  256,
                  alignment: Alignment.topLeft,
                  child: Image(image: AssetImage("lib/assets/images/favicon.png"),color: Colors.white,),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Hero(
                    tag: "txtLogo",
                    child: Material(
                        color: Colors.transparent,
                        child: Text(
                            "Smart Assistant",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            )
                        )
                    )
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                          "Manage your home by using phone everywhere",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          )
                      )
                  )
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