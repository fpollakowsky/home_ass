import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/onBoard/second.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:home_ass/utils/res/transitions.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorObservers: [VillainTransitionObserver()],
    home: OnBoardFirst(),
  ));
}

class OnBoardFirst extends StatefulWidget{
  _OnBoardFirst createState() => _OnBoardFirst();
}

class _OnBoardFirst extends State<OnBoardFirst> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadSharedPreferences();
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        home: Material(
            color: themeColor,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: "logo",
                    child: Container(
                      height: 256,
                      width:  256,
                      margin: EdgeInsets.all(16),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/256"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                  Hero(
                      tag: "txtLogo",
                      child: Material(
                          color: Colors.transparent,
                          child: Text(
                              "Placeholder",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              )
                          )
                      )
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
                    alignment: Alignment.centerRight,
                    width: double.infinity,
                    child: FlatButton(
                      color: primaryColor,
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.of(context).push(FadeRouteBuilder(page: OnBoardSecond()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.red)
                      ),
                      child: Text("Next"),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}