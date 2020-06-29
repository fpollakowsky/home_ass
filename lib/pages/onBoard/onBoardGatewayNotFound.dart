import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';

class OnBoardGatewayNotFound extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
        color: themeColor,
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 16),
                      alignment: Alignment.center,
                      child: Villain(
                          villainAnimation: VillainAnimation.fromBottom(
                              relativeOffset: 0.4,
                              from: Duration(milliseconds: 800),
                              to: Duration(milliseconds: 1300)
                          ),
                          secondaryVillainAnimation: VillainAnimation.fade(),
                          child: Text(
                              "Gateway not found",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.7
                              )
                          )
                      )
                  ),
                  Villain(
                    villainAnimation: VillainAnimation.fade(
                        from: Duration(milliseconds: 1000),
                        to: Duration(milliseconds: 1700),
                        fadeFrom: 0,
                        fadeTo: 1
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 64),
                      height: 256,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("lib/assets/images/failure.png"))
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.bottomCenter,
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 40,
                          child: RaisedButton(
                            color: primaryColor,
                            textColor: Colors.white,
                            onPressed: (){
                              setValueSharedPref("firstStart", false,"bool");
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.red)
                            ),
                            child: Text("Add manually"),
                          ),
                        )
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}
