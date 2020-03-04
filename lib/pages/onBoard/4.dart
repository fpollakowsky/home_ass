import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/styles.dart';
import 'package:home_ass/utils/res/transitions.dart';

class OnBoardFourth extends StatefulWidget{
  _OnBoardFourth createState() => _OnBoardFourth();
}

class _OnBoardFourth extends State<OnBoardFourth> {
  @override
  void initState() {
    super.initState();
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
                              height: 64,
                              width:  64,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  image: DecorationImage(
                                      image: NetworkImage("https://via.placeholder.com/256"),
                                      fit: BoxFit.cover
                                  )
                              ),
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
                                            "Placeholder",
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight:
                                                FontWeight.bold,
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
                      Villain(
                        villainAnimation: VillainAnimation.fromBottom(
                            relativeOffset: 0.4,
                            from: Duration(milliseconds: 500),
                            to: Duration(milliseconds: 1300)
                        ),
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        child: Container(
                          margin: EdgeInsets.only(top: 32),
                          padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          child: Column(
                            children: <Widget>[
                              Villain(
                                villainAnimation: VillainAnimation.fromBottom(
                                    relativeOffset: 0.05,
                                    from: Duration(milliseconds: 1000),
                                    to: Duration(milliseconds: 1500)
                                ),
                                secondaryVillainAnimation: VillainAnimation.fade(),
                                child: Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: Text(
                                    "User Information",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Villain(
                                villainAnimation: VillainAnimation.fromBottom(
                                    relativeOffset: 0.05,
                                    from: Duration(milliseconds: 1200),
                                    to: Duration(milliseconds: 1700)
                                ),
                                secondaryVillainAnimation: VillainAnimation.fade(),
                                child: Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: TextField(
                                    onSubmitted: (value){
                                      SystemChrome.setEnabledSystemUIOverlays([]);
                                      setState(() {});
                                    },
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                          borderSide: BorderSide(width: 2,color: primaryColor)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                          borderSide: BorderSide(width: 2,color: Colors.white)
                                      ),
                                      labelStyle: TextStyle(
                                          color: Colors.white
                                      ),
                                      labelText: "Name",
                                    ),
                                  ),
                                ),
                              ),
                              Villain(
                                villainAnimation: VillainAnimation.fromBottom(
                                    relativeOffset: 0.05,
                                    from: Duration(milliseconds: 1400),
                                    to: Duration(milliseconds: 1900)
                                ),
                                secondaryVillainAnimation: VillainAnimation.fade(),
                                child: Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: TextField(
                                    onSubmitted: (value){
                                      SystemChrome.setEnabledSystemUIOverlays([]);
                                      setState(() {});
                                    },
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                          borderSide: BorderSide(width: 2,color: primaryColor)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(16)),
                                          borderSide: BorderSide(width: 2,color: Colors.white)
                                      ),
                                      labelStyle: TextStyle(
                                          color: Colors.white
                                      ),
                                      labelText: "Nickname",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Villain(
                          villainAnimation: VillainAnimation.fromBottom(
                              relativeOffset: 0.4,
                              from: Duration(milliseconds: 1800),
                              to: Duration(milliseconds: 2300)
                          ),
                          secondaryVillainAnimation: VillainAnimation.fade(),
                          child: Container(
                              margin: EdgeInsets.only(top: 32),
                              padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                              decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                              child: Column(
                                  children: <Widget>[
                                    Villain(
                                      villainAnimation: VillainAnimation.fromBottom(
                                          relativeOffset: 0.05,
                                          from: Duration(milliseconds: 2000),
                                          to: Duration(milliseconds: 2500)
                                      ),
                                      secondaryVillainAnimation: VillainAnimation.fade(),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: TextField(
                                          obscureText: true,
                                          onSubmitted: (value){
                                            SystemChrome.setEnabledSystemUIOverlays([]);
                                            setState(() {});
                                          },
                                          cursorColor: Colors.white,
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                borderSide: BorderSide(width: 2,color: primaryColor)
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                                borderSide: BorderSide(width: 2,color: Colors.white)
                                            ),
                                            labelStyle: TextStyle(
                                                color: Colors.white
                                            ),
                                            labelText: "Password",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Villain(
                                        villainAnimation: VillainAnimation.fromBottom(
                                            relativeOffset: 0.05,
                                            from: Duration(milliseconds: 2200),
                                            to: Duration(milliseconds: 2700)
                                        ),
                                        secondaryVillainAnimation: VillainAnimation.fade(),
                                        child: Container(
                                            margin: EdgeInsets.only(top: 16),
                                            child: TextField(
                                                obscureText: true,
                                                onSubmitted: (value){
                                                  SystemChrome.setEnabledSystemUIOverlays([]);
                                                  setState(() {});
                                                },
                                                cursorColor: Colors.white,
                                                style: TextStyle(
                                                    color: Colors.white
                                                ),
                                                decoration: InputDecoration(
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                                        borderSide: BorderSide(width: 2,color: primaryColor)
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                                        borderSide: BorderSide(width: 2,color: Colors.white)
                                                    ),
                                                    labelStyle: TextStyle(
                                                        color: Colors.white
                                                    ),
                                                    labelText: "Repeat"
                                                )
                                            )
                                        )
                                    )
                                  ]
                              )
                          )
                      ),
                      Expanded(
                        child: Column(
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        height: 82,
                        width: double.infinity,
                        child: FlatButton(
                          color: primaryColor,
                          textColor: Colors.white,
                          onPressed: (){
                            Navigator.of(context).push(FadeRouteBuilder(page: OnBoardFourth()));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.red)
                          ),
                          child: Text("Next"),
                        ),
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }
}