import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/onBoard/SearchGateway.dart';
import 'package:home_ass/pages/onBoard/enterPersonalInformation.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:home_ass/utils/res/transitions.dart';

class OnBoardGender extends StatefulWidget{
  _OnBoardGender createState() => _OnBoardGender();
}

class _OnBoardGender extends State<OnBoardGender> {
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
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Hero(
                        tag: "logo",
                        child: Container(
                          height: 48,
                          width:  48,
                          alignment: Alignment.topLeft,
                          child: Image(image: AssetImage("lib/assets/images/favicon.png"),color: Colors.white,),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
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
                            )
                        ),
                      ),
                      Container(
                        height: 64,
                        width: 64,
                      )
                    ],
                  ),
                  Expanded(
                      child: Villain(
                        villainAnimation: VillainAnimation.fromBottom(
                            relativeOffset: 0.05,
                            from: Duration(milliseconds: 800),
                            to: Duration(milliseconds: 1300)
                        ),
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Hero(
                                  tag: "profilePicture_1",
                                  child: Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.all(Radius.circular(24)),
                                      onTap: (){
                                        setValueSharedPref("profilePicture", "lib/assets/images/male_profile.png", "string");
                                        loadProfilePicture().then((val){
                                          setHeroTagOnBoard("profilePicture_1");
                                          Navigator.of(context).push(FadeRouteBuilder(page: EnterPersonalInformation()));
                                        });
                                      },
                                      child: Container(
                                        height: 160,
                                        width: 160,
                                        child: Image(
                                            image: AssetImage("lib/assets/images/male_profile.png")
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: Text(
                                      "Male",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.white
                                      )
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Hero(
                                  tag: "profilePicture_2",
                                  child: Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                    child: InkWell(
                                      borderRadius: BorderRadius.all(Radius.circular(24)),
                                      onTap: (){
                                        setValueSharedPref("profilePicture", "lib/assets/images/woman_profile.png", "string");
                                        loadProfilePicture().then((val){
                                          setHeroTagOnBoard("profilePicture_2");
                                          Navigator.of(context).push(FadeRouteBuilder(page: EnterPersonalInformation()));
                                        });
                                      },
                                      child: Container(
                                        height: 160,
                                        width: 160,
                                        child: Image(
                                            image: AssetImage("lib/assets/images/woman_profile.png")
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: Text(
                                      "Female",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.white
                                      )
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ),
                  Container(
                    height: 64,
                  )
                ],
              ),
            )
        )
    );
  }
}