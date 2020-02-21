import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/styles.dart';

final List<String> topicList = <String>['Setup Devices','Gateway','Privacy','Other','Bug Report'];

class SupportPage extends StatefulWidget {
  @override
  _SupportPage createState() => new _SupportPage();
}

class _SupportPage extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryDarkColor,
      child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text("Support", style: H1B),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8, top: 16),
                  child: Text("Topics", style: H2B),
                ),
                Container(
                  child: Villain(
                    villainAnimation: VillainAnimation.fromBottom(
                        relativeOffset: 0.3,
                        curve: Curves.easeIn,
                        from: Duration(milliseconds: 100),
                        to: Duration(milliseconds: 600)
                    ),
                    secondaryVillainAnimation: VillainAnimation.fade(),
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      child: ListView.builder(shrinkWrap: true,
                        itemCount: topicList.length,
                        itemBuilder: (BuildContext context, int index){
                          return Material(
                            color: cardColor,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: InkWell(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              onTap: (){},
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            topicList[index],
                                            style: H3
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          );
                        },
                      )
                    ),
                  )
                )
              ],
            ),
          )
      ),
    );
  }
}

