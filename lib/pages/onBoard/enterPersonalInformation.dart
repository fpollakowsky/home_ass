import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/onBoard/SearchGateway.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:home_ass/utils/res/transitions.dart';

class EnterPersonalInformation extends StatefulWidget{
  _EnterPersonalInformation createState() => _EnterPersonalInformation();
}

class _EnterPersonalInformation extends State<EnterPersonalInformation> {
  final formKeyPI  = GlobalKey<FormState>();

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
        home: Material(
            color: themeColor,
            child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Form(
                    key: formKeyPI,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: heroTagOnBoard,
                          child: Container(
                            height: 196,
                            width: 196,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Image(
                                image: AssetImage(valProfile)
                            ),
                          ),
                        ),
                        Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.05,
                                from: Duration(milliseconds: 500),
                                to: Duration(milliseconds: 1000)
                            ),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            child: Container(
                              margin: EdgeInsets.only(top: 32),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white,width: 2)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green,width: 2)
                                  ),
                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                ),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                ),
                                onSaved: (value){
                                  setValueSharedPref("name", value, "string");
                                },
                              ),
                            )
                        ),
                        Expanded(
                          child: Villain(
                              villainAnimation: VillainAnimation.fromBottom(
                                  relativeOffset: 0.05,
                                  from: Duration(milliseconds: 800),
                                  to: Duration(milliseconds: 1300)
                              ),
                              secondaryVillainAnimation: VillainAnimation.fade(),
                              child: Container(
                                margin: EdgeInsets.only(top: 16),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter nickname';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,width: 2)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green,width: 2)
                                    ),
                                    labelText: "Nickname",
                                    labelStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                  onSaved: (value){
                                    setValueSharedPref("nickname", value, "string");
                                  },
                                ),
                              )
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: ButtonTheme(
                            height: 40,
                            minWidth: double.infinity,
                            child: FlatButton(
                              color: primaryColor,
                              textColor: Colors.white,
                              onPressed: (){
                                if (formKeyPI.currentState.validate()) {
                                  formKeyPI.currentState.save();
                                  loadSharedPreferences().then((val){
                                    Navigator.of(context).push(FadeRouteBuilder(page: OnBoardSearchGateway()));
                                  });
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text("Save"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                )
            )
        )
    );
  }
}